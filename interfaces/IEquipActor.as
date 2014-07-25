package Common.core.model.prop.interfaces
{
    import Common.base.vo.item.EquipInfo;
    import Common.core.model.prop.equip.EquipEnum;

    /**
     * <ui>
     *<li>desc:用于装备数据处理</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-19 下午1:28:13 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public interface IEquipActor
    {
        /**
         * 通过DbId获取装备详细信息
         * @param dbId
         * @return
         */
        function getEquipInfo(dbId:String):EquipInfo;

        /**
         * 获取某个指定位置的装备信息
         * @param pos
         * @return
         */
        function getEquipInfoByPos(pos:int):EquipInfo;

        /**
         * 获取指定配置ID的所有装备的信息
         * @param configId
         * @return
         */
        function getEquipListByConfigId(configId:int):Vector.<EquipInfo>;

        /**
         * 获取英雄装备（装备分英雄装备和心魔装备）
         * @param type
         * @return
         */
        function getHeroEquipList(type:int = EquipEnum.NOT_EQUIP):Vector.<EquipInfo>;
    }
}
