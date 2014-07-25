package Common.core.model.prop.equip
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-11-21 下午6:45:36 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;

    import moebius.lib.event.base.CommEvent;

    public class EquipActorEvent extends CommEvent
    {
        public static const EQUIP_ITEM_ADD:String = "equipItemAdd";

        public static const EQUIP_ITEM_REMOVE:String = "equipItemRemove";

        public static const EQUIP_ITEM_UPDATE:String = "equipItemUpdate";

        public static const EQUIP_ITEM_ADD_NUM:String = "equipItemAddNum";
        public static const BAG_PAGE_NEED_CHANGE:String = "bagPageNeedChange";

        public function EquipActorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, data, bubbles, cancelable);
        }

        public function getEquipInfo():EquipInfo
        {
            return getData() as EquipInfo;
        }

        public function getItemInfo():ItemInfo
        {
            return getData() as ItemInfo;
        }
    }
}
