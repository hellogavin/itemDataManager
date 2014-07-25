package Common.core.model.prop
{
    /**
     * <ui>
     *<li>desc:获得所有物品包括背包、仓库、玩家身上、已经买了的物品</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-19 下午3:46:11 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.enum.item.CellTypeEnum;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BasePropActor;
    import Common.core.model.prop.equip.EquipActor;
    import Common.core.model.prop.item.ItemActor;
    import Common.core.model.prop.shop.SoldItemActor;

    import moebius.base.structure.HashMap;

    public class PropActor extends BasePropActor
    {
        [Inject]
        public var i_ItemActor:ItemActor;
        [Inject]
        public var i_EquipActor:EquipActor;
        [Inject]
        public var i_SoldActor:SoldItemActor;

        public function PropActor()
        {
            super();
        }

        override public function get dataList():HashMap
        {
            var data:HashMap = new HashMap();
            for each (var itemInfo:ItemInfo in i_ItemActor.dataList.getContent())
            {
                data.put(itemInfo.getID(), itemInfo);
            }
            for each (var equipInfo:EquipInfo in i_EquipActor.dataList.getContent())
            {
                data.put(equipInfo.getID(), equipInfo);
            }
            for each (var info:* in i_SoldActor.dataList.getContent())
            {
                data.put(info.getID(), info);
            }
            return data;
        }


        public function getNotSellPropCount(configId:int):int
        {
            var count:int = 0;
            for each (var itemInfo:ItemInfo in dataList.getContent())
            {
                if (itemInfo.getConfigID() == configId && itemInfo.getOwnerID() != CellTypeEnum.SOLD)
                    count += itemInfo.getCount();
            }
            return count;
        }
    }
}
