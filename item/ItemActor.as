package Common.core.model.prop.item
{
    import Common.base.config.item.ItemConfigInfo;
    import Common.base.enum.com.ColorEnum;
    import Common.base.enum.item.CellTypeEnum;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BaseItemActor;

    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-10 下午1:37:08 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public class ItemActor extends BaseItemActor
    {
        private var _isInit:Boolean;

        public function ItemActor()
        {
            super();
        }

        public function init():void
        {
            _isInit = true;
            dispatch(new ItemActorEvent(ItemActorEvent.ITEM_INIT_LOADED));
        }

        public function get isInit():Boolean
        {
            return _isInit;
        }

        public function handleItem(info:ItemInfo):void
        {
            if (null == info)
                return;
            if (info.m_Count == 0)
                removeItem(info.getID());
            else
                dataList.containsKey(info.getID()) ? updateItem(info) : addItem(info);
        }

        public function addItem(info:ItemInfo):void
        {
            dataList.put(info.getID(), info);
            notice(ItemActorEvent.ITEM_ADD, info);
            var itemConfigInfo:ItemConfigInfo = i_ItemConfig.getConfigInfo(info.getConfigID());
            info.setItemPrice(itemConfigInfo.sold);
            info.m_ItemNumChanged = info.m_ItemOwnerChanged = false;
        }

        public function removeItem(id:String):void
        {
            if (!dataList.containsKey(id))
                return;
            notice(ItemActorEvent.ITEM_REMOVE, dataList.remove(id));
        }

        public function updateItem(info:ItemInfo):void
        {
            dataList.put(info.getID(), info);
            notice(ItemActorEvent.ITEM_UPDATE, info);
            if (info.m_ItemNumChanged || info.m_ItemOwnerChanged)
                notice(ItemActorEvent.BAG_PAGE_NEED_CHANGE, info);
            info.m_ItemNumChanged = info.m_ItemOwnerChanged = false;
        }

        protected function notice(eventName:String, info:ItemInfo):void
        {
            if (isInit)
                dispatch(new ItemActorEvent(eventName, info));
        }

        /**
         *  获得背包或仓库里的物品（可使用物品），因为有可能有别的背包里的物品
         * @param type
         * @return
         *
         */
        public function getUsableItemByType(type:int):Array
        {
            var data:Array = [];
            for each (var info:ItemInfo in dataDic)
            {
                var configInfo:ItemConfigInfo = getConfigByConfigId(info.m_ConfigID);
                if (configInfo.type == type)
                {
                    if (info.getOwnerID() == CellTypeEnum.BAG || info.getOwnerID() == CellTypeEnum.STORAGE)
                        data.push(info);
                }
            }
            return data;
        }

        /**
         * 获取道具是否足够时的颜色
         * @param itemId
         * @param needed
         * @return
         */
        public function getEnoughColor(itemId:int, needed:int):uint
        {
            return getItemListByConfigId(itemId).length >= needed ? ColorEnum.BASIC_GREEN : ColorEnum.BASIC_RED;
        }
    }
}
