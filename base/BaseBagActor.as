package Common.core.model.prop.base
{
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.equip.EquipActor;
    import Common.core.model.prop.interfaces.IBagActor;
    import Common.core.model.prop.item.ItemActor;

    /**
     * <ui>
     *<li>desc:背包类数据管理基类</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-10 上午10:36:11 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public class BaseBagActor extends BaseItemActor implements IBagActor
    {
        [Inject]
        public var i_ItemActor:ItemActor;
        [Inject]
        public var i_EquipActor:EquipActor;
        protected var m_Volume:int;

        public function BaseBagActor()
        {
        }

        /**
         * 获取背包空格数量
         * @return 空格数量
         */
        public function getFirstFreePos():int
        {
            for (var i:int = 0; i < getVolume(); ++i)
            {
                var flag:Boolean = true;
                for each (var info:ItemInfo in dataList.getContent())
                {
                    if (info.getPos() == i)
                    {
                        flag = false;
                        break;
                    }
                }
                if (flag)
                    return i;
            }
            return -1;
        }

        public function getVolume():int
        {
            return m_Volume;
        }

        /** 查询 指定位置的物品信息    */
        public function getInfoByPos(pos:int):*
        {
            for each (var info:ItemInfo in dataList.getContent())
            {
                if (info.getPos() == pos)
                    return info;
            }
            return null;
        }
    }
}
