package Common.core.model.prop.shop
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-11-19 上午9:57:30 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.vo.item.ItemInfo;

    import moebius.lib.event.base.CommEvent;

    public class SoldItemActorEvent extends CommEvent
    {
        public static const ADD_SOLD_ITEM:String = "addSoldItem";

        public static const UPDATE_SOLD_ITEM:String = "updateSoldItem";

        public static const REMOVE_SOLD_ITEM:String = "removeSoldItem";

        public function SoldItemActorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, data, bubbles, cancelable);
        }

        public function getItemInfo():ItemInfo
        {
            return getData() as ItemInfo;
        }
    }
}