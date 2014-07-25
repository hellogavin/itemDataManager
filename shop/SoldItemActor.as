package Common.core.model.prop.shop
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-11-19 上午9:43:14 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BaseEquipActor;
    import Common.core.model.prop.equip.EquipActor;
    import Common.core.model.prop.item.ItemActor;

    public class SoldItemActor extends BaseEquipActor
    {
        [Inject]
        public var i_ItemActor:ItemActor;
        [Inject]
        public var i_EquipActor:EquipActor;

        private var m_ItemData:Array;

        public function SoldItemActor()
        {
            super();
        }

        public function addItem(info:*):void
        {
            if (info.m_ExpireTime <= 0)
                return;
            dataList.put(info.getID(), info);
            if (info is EquipInfo)
            {
                getEquipPower(info);
                initEquipSoldPrice(info);
                i_EquipActor.removeEquip(info.getID());
            }
            else
            {
                i_ItemActor.removeItem(info.getID());
                initItemSoldPrice(info);
            }
            dispatch(new SoldItemActorEvent(SoldItemActorEvent.ADD_SOLD_ITEM));
        }

        public function removeItem(id:String):void
        {
            if (!dataList.containsKey(id))
                return;
            dispatch(new SoldItemActorEvent(SoldItemActorEvent.REMOVE_SOLD_ITEM, dataList.remove(id)));
        }

        public function getItemCount():int
        {
            return dataList.size();
        }

        public function getEquipInfo(dbId:String):EquipInfo
        {
            for each (var info:ItemInfo in m_ItemData)
            {
                if (info.m_ID == dbId)
                    return info as EquipInfo;
            }
            return null;
        }

        public function getDataArray():Array
        {
            m_ItemData = [];
            for each (var info:ItemInfo in dataList.getContent())
            {
                m_ItemData.push(info);
            }
            m_ItemData.sortOn("m_ExpireTime", Array.DESCENDING);
            return m_ItemData;
        }
    }
}
