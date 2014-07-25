package Common.core.model.prop.bag
{
    import Common.base.config.dropbag.DropDetailInfo;
    import Common.base.config.item.ItemConfigInfo;
    import Common.base.enum.ModuleEventEnum;
    import Common.base.enum.ModuleTypeEnum;
    import Common.base.enum.dropbag.DropInfoTypeEnum;
    import Common.base.enum.item.BagFilterTypeEnum;
    import Common.base.enum.item.CellTypeEnum;
    import Common.base.enum.item.ItemTypeEnum;
    import Common.base.vo.TIVInfo;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BaseBagActor;
    import Common.interfaces.IModuleEvent;
    import Common.utility.SortUtility;

    import moebius.base.structure.HashMap;

    /******************************************************
     *
     * 创建者：cory
     * 功能：
     * 说明：
     *
     ******************************************************/
    public class BagActor extends BaseBagActor
    {
        /**  打开背包时间戳         */
        private var m_BagOpenTime:int;

        public var m_BagCanExtend:Boolean;

        [Inject]
        public var i_ModuleEvent:IModuleEvent;

        public function BagActor():void
        {
            super();
        }

        /**  查询    物品列表根据背包筛选类型(除装备外)         */
        public function getItemListByBagType(type:int):Array
        {
            var list:Array = [];
            switch (type)
            {
                case BagFilterTypeEnum.IMMORTALITY:
                    list = getItemArrayByType(ItemTypeEnum.IMMORTALITY);
                    break;
                case BagFilterTypeEnum.STUFF:
                    list = getItemArrayByType(ItemTypeEnum.MATERIAL);
                    break;
                case BagFilterTypeEnum.PROPS:
                    list = getProps();
                    break;
                case BagFilterTypeEnum.EQUIP:
                    list = getItemArrayByType(ItemTypeEnum.EQUIP);
            }
            list.sort(SortUtility.ASCENDING);
            return list;
        }

        public function getEquipList():Vector.<EquipInfo>
        {
            var data:Vector.<EquipInfo> = new Vector.<EquipInfo>();
            for each (var info:ItemInfo in dataList.getContent())
            {
                if (info is EquipInfo)
                    data.push(info);
            }
            return data;
        }

        /**  获得道具分类物品         */
        private function getProps():Array
        {
            var list:Array = [];
            for each (var info:ItemInfo in dataList.getContent())
            {
                var type:int = i_ItemConfig.getTypeByID(info.getConfigID());
                if (type != ItemTypeEnum.EQUIP && type != ItemTypeEnum.IMMORTALITY && type != BagFilterTypeEnum.STUFF)
                    list.push(info);
            }
            return list;
        }

        /**  设置背包已开格子数和开放格子CD时间         */
        public function setVolume(data:Array):void
        {
            m_Volume = data[1];
            m_BagOpenTime = data[2];
            dispatch(new BagActorEvent(BagActorEvent.UPDATE_PACKAGE_VOLUME));
        }

        public function getOpenTime():int
        {
            return m_BagOpenTime;
        }

        override public function get dataList():HashMap
        {
            var data:HashMap = new HashMap();
            for each (var itemInfo:ItemInfo in i_ItemActor.dataList.getContent())
            {
                if (itemInfo.getOwnerID() == CellTypeEnum.BAG)
                {
                    data.put(itemInfo.getID(), itemInfo);
                }
            }
            for each (var equipInfo:EquipInfo in i_EquipActor.dataList.getContent())
            {
                if (equipInfo.getOwnerID() == CellTypeEnum.BAG)
                {
                    data.put(equipInfo.getID(), equipInfo);
                }
            }
            return data;
        }

        public function getBlankPos():int
        {
            return getVolume() - dataList.size();
        }

        /**
         * 通过要增加的道具数据，检测背包是否满
         * @param value
         * @return
         */
        public function checkBagFullByData(value:Array):Boolean
        {
            var place:int = 0;
            var itemConfigInfo:ItemConfigInfo;
            var id:int;
            var count:int;
            for each (var info:* in value)
            {
                if (info.type == DropInfoTypeEnum.ITEM)
                {
                    if (info is TIVInfo)
                    {
                        id = info.id;
                        count = info.value;
                    }
                    else if (info is DropDetailInfo)
                    {
                        id = info.prize;
                        count = info.count;
                    }
                    itemConfigInfo = i_ItemConfig.getConfigInfo(id);
                    place += Math.ceil(count / itemConfigInfo.max_count);
                }
            }
            return checkBagFull(place);
        }

        /**
         * 检测背包是否满
         * 满的话自动提示玩家
         * @param value
         * @return
         */
        public function checkBagFull(value:int = 0, isTip:Boolean = true, isOpen:Boolean = true):Boolean
        {
            if (getBlankPos() <= value)
            {
                if (isTip)
                    i_ModuleEvent.createEvent(ModuleEventEnum.PROMPT_TEXT, "背包已满，请清理背包").dispatchToModule();
                if (isOpen)
                    i_ModuleEvent.openModule(ModuleTypeEnum.BAG);
                return true;
            }
            return false;
        }
    }
}
