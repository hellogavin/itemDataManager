package Common.core.model.prop.interfaces
{
    /**
     * <ui>
     *<li>desc:主要用于背包、仓库等</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-19 下午2:06:18 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public interface IBagActor
    {
        /**
         * 获取指定位置的物品信息
         * @param pos
         * @return
         */
        function getInfoByPos(pos:int):*

        /**
         * 获取背包中第一个可用空格
         * @return
         */
        function getFirstFreePos():int;

        /**
         * 获取背包容量
         * @return
         */
        function getVolume():int;
    }
}
