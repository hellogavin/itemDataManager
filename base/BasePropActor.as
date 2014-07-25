package Common.core.model.prop.base
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-19 下午1:53:27 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.config.item.ItemConfig;
    import Common.base.config.item.ItemConfigInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.interfaces.IPropActor;

    import flash.utils.Dictionary;

    import moebius.base.structure.HashMap;
    import moebius.module.core.ModelActor;

    public class BasePropActor extends ModelActor implements IPropActor
    {
        [Inject]
        public var i_ItemConfig:ItemConfig;

        private var m_DataList:HashMap;

        public function BasePropActor()
        {
            m_DataList = new HashMap();
        }

        /** 查询    物品配置(包括物品和装备)         */
        public function getConfigByDbId(dbId:String):ItemConfigInfo
        {
            var itemInfo:ItemInfo = getItemInfo(dbId);
            if (itemInfo == null)
                return null;
            return getConfigByConfigId(itemInfo.m_ConfigID);
        }

        public function getConfigByConfigId(configId:int):ItemConfigInfo
        {
            return i_ItemConfig.getConfigInfo(configId);
        }

        public function getList():HashMap
        {
            return m_DataList;
        }

        public function getCountByConfigId(configId:int):int
        {
            var count:int;
            for each (var itemInfo:ItemInfo in dataList.getContent())
            {
                if (itemInfo.getConfigID() == configId)
                    count += itemInfo.getCount();
            }
            return count;
        }

        /** 查询    物品info         */
        public function getItemInfo(dbId:String):ItemInfo
        {
            return dataList.get(dbId);
        }

        public function get dataList():HashMap
        {
            return m_DataList;
        }

        public function get dataDic():Dictionary
        {
            return dataList.getContent();
        }
    }
}
