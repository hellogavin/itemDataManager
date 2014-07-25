package Common.core.model.prop.base
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-11-19 下午3:36:21 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.config.item.ItemConfigInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.interfaces.IItemActor;

    public class BaseItemActor extends BasePropActor implements IItemActor
    {
        public function BaseItemActor()
        {
        }

        public function getItemListByConfigId(configId:int):Vector.<ItemInfo>
        {
            var list:Vector.<ItemInfo> = new Vector.<ItemInfo>();
            for each (var info:ItemInfo in dataDic)
            {
                if (info.getConfigID() == configId)
                    list.push(info);
            }
            return list;
        }

        /**
         * 根据物品类型获取物品数据
         * @param type
         * @return
         */
        public function getItemListByType(type:int):Vector.<ItemInfo>
        {
            var list:Vector.<ItemInfo> = new Vector.<ItemInfo>();
            for each (var info:ItemInfo in dataDic)
            {
                var configInfo:ItemConfigInfo = getConfigByConfigId(info.m_ConfigID);
                if (configInfo.type == type)
                    list.push(info);
            }
            return list;
        }

        public function getItemArrayByType(type:int):Array
        {
            var data:Array = [];
            for each (var info:ItemInfo in dataDic)
            {
                var configInfo:ItemConfigInfo = getConfigByConfigId(info.m_ConfigID);
                if (configInfo.type == type)
                    data.push(info);
            }
            return data;
        }
    }
}
