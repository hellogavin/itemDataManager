package Common.core.model.prop.item
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-10 下午5:26:09 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.vo.item.ItemInfo;

    import moebius.lib.event.base.CommEvent;

    public class ItemActorEvent extends CommEvent
    {
        /**  物品加载完成         */
        public static const ITEM_INIT_LOADED:String = "ItemInitLoaded";
        /** 新增物品         */
        public static const ITEM_ADD:String = "itemAdd";

        public static const ITEM_REMOVE:String = "itemRemove";
        /** 物品更新数量或位置等         */
        public static const ITEM_UPDATE:String = "itemUpdate";

        public static const BAG_PAGE_NEED_CHANGE:String = "bagPageNeedChange";

        public function ItemActorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, data, bubbles, cancelable);
        }

        public function getItemInfo():ItemInfo
        {
            return getData() as ItemInfo;
        }
    }
}
