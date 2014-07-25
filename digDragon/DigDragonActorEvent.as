package Common.core.model.prop.digDragon
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2014-2-19 下午5:38:31 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import moebius.lib.event.base.CommEvent;

    public class DigDragonActorEvent extends CommEvent
    {
        public function DigDragonActorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, data, bubbles, cancelable);
        }
    }
}