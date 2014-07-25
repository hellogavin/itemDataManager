package Common.core.model.prop.interfaces
{
    import Common.base.config.item.ItemConfigInfo;
    import Common.base.vo.item.ItemInfo;

    import moebius.base.structure.HashMap;

    /**
     * <ui>
     *<li>desc:整体数据处理，包括装备和物品</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-19 下午1:22:53 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public interface IPropActor
    {
        /**
         * 获取某DbId的物品的配置信息
         * @param dbId
         * @return
         */
        function getConfigByDbId(dbId:String):ItemConfigInfo;
        /**
         * 获取某配置ID的物品数量
         * @param configId
         * @return
         */
        function getCountByConfigId(configId:int):int;
        /**
         * 获取某配置Id的配置数据
         * @param configId
         * @return
         */
        function getConfigByConfigId(configId:int):ItemConfigInfo;
        /**
         * 获取所有物品数据
         * @return
         */
        function getList():HashMap;

        /**
         * 获取指定DbId的物品信息
         * @param dbId
         * @return
         */
        function getItemInfo(dbId:String):ItemInfo;
        function get dataList():HashMap;
    }
}
