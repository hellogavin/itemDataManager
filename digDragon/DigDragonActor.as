package Common.core.model.prop.digDragon
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2014-2-19 下午5:38:12 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.config.item.CellConfig;
    import Common.base.enum.item.CellTypeEnum;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BaseBagActor;

    import moebius.base.structure.HashMap;

    public class DigDragonActor extends BaseBagActor
    {
        [Inject]
        public var i_CellConfig:CellConfig;

        public function DigDragonActor()
        {
            super();
        }

        override public function get dataList():HashMap
        {
            var data:HashMap = new HashMap();
            for each (var itemInfo:ItemInfo in i_ItemActor.dataList.getContent())
            {
                if (itemInfo.getOwnerID() == CellTypeEnum.DIG_DRAGON)
                {
                    data.put(itemInfo.getID(), itemInfo);
                }
            }
            for each (var equipInfo:EquipInfo in i_EquipActor.dataList.getContent())
            {
                if (equipInfo.getOwnerID() == CellTypeEnum.DIG_DRAGON)
                {
                    data.put(equipInfo.getID(), equipInfo);
                }
            }
            return data;
        }
    }
}
