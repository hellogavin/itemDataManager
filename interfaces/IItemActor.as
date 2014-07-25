package Common.core.model.prop.interfaces
{
    import Common.base.config.item.ItemConfigInfo;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;

    import flash.utils.Dictionary;

    /**
     * <ui>
     *<li>desc:用于物品数据处理</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-10 上午10:41:13 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public interface IItemActor
    {
        /**
         * 获取指定配置ID的所有物品
         * @param configId
         * @return
         */
        function getItemListByConfigId(configId:int):Vector.<ItemInfo>;

        /**
         * 获取某类物品
         * @param type
         * @return
         */
        function getItemListByType(type:int):Vector.<ItemInfo>;
    }
}
