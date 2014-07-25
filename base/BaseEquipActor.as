package Common.core.model.prop.base
{
    import Common.base.config.com.FunctionRatioConfig;
    import Common.base.config.com.LevelExpConfig;
    import Common.base.config.equip.EquipConfig;
    import Common.base.config.item.ItemConfigInfo;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.base.vo.item.RecastPropertyInfo;
    import Common.core.model.role.FightPowerPropInfo;

    import flash.utils.Dictionary;

    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-12-19 下午2:28:52 </li>
     *</ui>
     *@author zhengxuesong
     * */
    public class BaseEquipActor extends BasePropActor
    {
        [Inject]
        public var i_LevelExpConfig:LevelExpConfig;
        [Inject]
        public var i_EquipConfig:EquipConfig;
        [Inject]
        public var i_FuncRatio:FunctionRatioConfig;

        public function BaseEquipActor()
        {
        }

        /**  初始化装备战力         */
        public function getEquipPower(info:EquipInfo):void
        {
            var propertyDic:Dictionary = new Dictionary();
            for (var i:int = 1; i < 23; i++)
            {
                propertyDic[i + ''] = 0;
            }
            var configInfo:ItemConfigInfo = getConfigByConfigId(info.getConfigID());//getConfigBydbId(info.getID());
            var propertyArr:Array = configInfo.attri.split(",");
            for (i = 0; i < propertyArr.length; i++)
            {
                var value:Array = propertyArr[i].split("|");
                var refineRate:int = 0;
                for each (var data:int in info.m_RefineProperty)
                    refineRate += data;
                var enhanceValue:int = parseInt(value[2], 10) * info.getEnhanceLevel();
                var refineValue:Number = parseInt(value[1], 10) * refineRate * 0.01;
                var propertyValue:int = parseInt(value[1], 10) + enhanceValue + refineValue;
                propertyDic[value[0]] += propertyValue;
            }

            //初始化镀金属性
            var plateArr:Array = info.m_PolishProperty;
            for (i = 0; i < 6; i++)
            {
                if (info.m_GoldPlatLevel < 0)
                    break;
                var plateValue:int = i_LevelExpConfig.getExpByLevel(234, info.m_GoldPlatLevel);
                propertyDic[i + ''] += plateValue;
            }

            //重铸属性
            var recastVec:Vector.<RecastPropertyInfo> = info.m_RecastProperty;
            if (configInfo.lv >= 20)
            {
                for (i = 0; i < recastVec.length; i++)
                {
                    var recastInfo:RecastPropertyInfo = info.m_RecastProperty[i];
                    var addPercent:Number = i_EquipConfig.getRecastProp(configInfo.rare, recastInfo.m_Star).percent;
                    var maxValue:int = i_EquipConfig.getIdentByEquipLv(configInfo.lv).getMaxValueByType(recastInfo.m_Type);
                    var recastValue:int = maxValue * addPercent + maxValue * recastInfo.m_IdentifyCount * i_FuncRatio.getDataById(231);
                    propertyDic[recastInfo.m_Type + ''] += recastValue;
                }
            }

            //初始化宝石战力
            var gem:Array = info.m_InlayProperty;
            for (i = 0; i < 4; i++)
            {
                if (gem[i] == 0 || gem.length <= i)
                    break;
                else
                {
                    configInfo = i_ItemConfig.getConfigInfo(gem[i]);
                    var attrs:Array = configInfo.attri.split("|");
                    propertyDic[attrs[0] + ''] += int(attrs[1]);
                }
            }

            var fight:FightPowerPropInfo = new FightPowerPropInfo(i_LevelExpConfig);
            info.m_FightPowerInfo = new FightPowerPropInfo(i_LevelExpConfig);
            for (i = 1; i < 23; i++)
            {
                var power:Number = Number(propertyDic[i + '']);
                fight.setPowerProp(i, power);
            }
            info.m_FightPowerInfo.add(fight);
        }

        /**
         * 初始化售价
         * @param info
         */
        protected function initEquipSoldPrice(info:EquipInfo):void
        {
            var price:int = i_ItemConfig.getConfigInfo(info.m_ConfigID).sold;
            price += i_LevelExpConfig.getTotalExpByLevel(200, (info.getEnhanceLevel() - 1)) * i_FuncRatio.getDataById(247);
            var baseIdentityId:int = 213;
            for each (var recastInfo:RecastPropertyInfo in info.m_RecastProperty)
            {
                for (var i:int = 0; i < recastInfo.m_IdentifyCount; i++)
                {
                    price += i_LevelExpConfig.getExpByLevel(baseIdentityId + i, info.m_Level) * i_FuncRatio.getDataById(248);
                }
            }
            info.m_ItemPrice = price;
        }

        protected function initItemSoldPrice(info:ItemInfo):void
        {
            var itemConfigInfo:ItemConfigInfo = i_ItemConfig.getConfigInfo(info.getConfigID());
            info.m_ItemPrice = itemConfigInfo.sold;
        }
    }
}
