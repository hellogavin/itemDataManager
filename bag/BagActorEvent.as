package Common.core.model.prop.bag
{
    import Common.base.vo.item.ItemInfo;

    import moebius.lib.event.base.CommEvent;

    /******************************************************
     *
     * 创建者：cory
     * 功能：
     * 说明：
     *
     ******************************************************/
    public class BagActorEvent extends CommEvent
    {
        /** 更新物品列表         */
        public static const ITEM_LIST_UPDATE:String = "item_list_update";
        /** 新得到了物品         */
        public static const ITEM_ADD_BAG:String = "itemAddBag";
        /**  从仓库里移动了物品过来         */
        public static const ITEM_ADD_FROM_STORGE:String = "itemAddFromStorge";
        /** 移除         */
        public static const ITEM_REMOVE_BAG:String = "itemRemoveBag";
        public static const ITEM_MOVE_TO_STORGE:String = "itemMoveToStorge";
        /** 更新         */
        public static const ITEM_UPDATE_BAG:String = "itemUpdateBag";
        /** 合并         */
        public static const ITEM_COMBINE:String = "item_combine";
        /** 传承         */
        public static const ITEM_INHERIT:String = "item_inherit";
        /** 更新背包容量  */
        public static const UPDATE_PACKAGE_VOLUME:String = "itemUpdatePackageVolume";

        public function BagActorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, data, bubbles, cancelable);
        }

        public function getItemInfo():ItemInfo
        {
            return getData() as ItemInfo;
        }
    }
}
