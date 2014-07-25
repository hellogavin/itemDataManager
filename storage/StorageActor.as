package Common.core.model.prop.storage
{
    import Common.base.config.item.CellConfig;
    import Common.base.enum.item.CellTypeEnum;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BaseBagActor;

    import moebius.base.structure.HashMap;

    /******************************************************
     *
     * 创建者：njw
     * 功能：
     * 说明：
     *
     ******************************************************/
    public class StorageActor extends BaseBagActor
    {
        [Inject]
        public var i_CellConfig:CellConfig;

        public function StorageActor()
        {
            super();
        }

        public function setVolume(volume:int):void
        {
            m_Volume = volume;
            dispatch(new StorageActorEvent(StorageActorEvent.VOLUME_UPDATE_STORGE));
        }

        override public function get dataList():HashMap
        {
            var data:HashMap = new HashMap();
            for each (var itemInfo:ItemInfo in i_ItemActor.dataList.getContent())
            {
                if (itemInfo.getOwnerID() == CellTypeEnum.STORAGE)
                {
                    data.put(itemInfo.getID(), itemInfo);
                }
            }
            for each (var equipInfo:EquipInfo in i_EquipActor.dataList.getContent())
            {
                if (equipInfo.getOwnerID() == CellTypeEnum.STORAGE)
                {
                    data.put(equipInfo.getID(), equipInfo);
                }
            }
            return data;
        }
    }
}
