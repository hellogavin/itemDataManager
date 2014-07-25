package Common.core.model.prop.storage
{
    import Common.base.vo.item.ItemInfo;

    import moebius.lib.event.base.CommEvent;

    /******************************************************
     *
     * 创建者：njw
     * 功能：
     * 说明：
     *
     ******************************************************/
    public class StorageActorEvent extends CommEvent
    {
        public static const ITEM_ADD_STORGE:String = "itemAddStorge";
        public static const ITEM_ADD_FROM_BAG:String = "itemAddFromBag";
        public static const ITEM_REMOVE_STORGE:String = "itemRremoveStorge";
        public static const ITEM_UPDATE_STORGE:String = "itemUpdateStorge";
        public static const ITEM_MOVE_TO_BAG:String = "itemMoveToBag";

        public static const VOLUME_UPDATE_STORGE:String = "volumeUpdateStorge";

        public function StorageActorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, data, bubbles, cancelable);
        }

        public function getItemInfo():ItemInfo
        {
            return getData() as ItemInfo;
        }
    }
}
