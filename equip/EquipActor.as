package Common.core.model.prop.equip
{
    /**
     * <ui>
     *<li>desc:</li>
     * <li>E-mail: hellogavin1988#gmail.com</li>
     * <li>version 1.0.0</li>
     *<li> 创建时间：2013-11-21 下午6:05:13 </li>
     *</ui>
     *@author zhengxuesong
     * */

    import Common.base.config.item.ItemConfigInfo;
    import Common.base.enum.item.CellTypeEnum;
    import Common.base.vo.item.EquipInfo;
    import Common.base.vo.item.ItemInfo;
    import Common.core.model.prop.base.BaseEquipActor;
    import Common.core.model.prop.interfaces.IEquipActor;
    import Common.utility.NumberUtility;

    public class EquipActor extends BaseEquipActor implements IEquipActor
    {
        public function EquipActor()
        {
            super();
        }

        public function handleEquip(info:EquipInfo):void
        {
            if (null == info)
                return;
            if (info.m_Count == 0)
                removeEquip(info.getID());
            else
                dataList.containsKey(info.getID()) ? updateEquip(info) : addEquip(info);
        }

        public function addEquip(info:EquipInfo):void
        {
            dataList.put(info.getID(), info);
            getEquipPower(info);
            initEquipSoldPrice(info);
            notice(EquipActorEvent.EQUIP_ITEM_ADD, info);
            info.m_ItemNumChanged = info.m_ItemOwnerChanged = false;
        }

        public function removeEquip(id:String):void
        {
            if (!dataList.containsKey(id))
                return;
            notice(EquipActorEvent.EQUIP_ITEM_REMOVE, dataList.remove(id));
        }

        public function updateEquip(info:EquipInfo):void
        {
            var equipInfo:EquipInfo = getEquipInfo(info.getID());
            if (equipInfo.getCount() < equipInfo.getCount())
                notice(EquipActorEvent.EQUIP_ITEM_ADD_NUM, info);
            dataList.put(info.getID(), info);
            getEquipPower(info);
            initEquipSoldPrice(info);
            notice(EquipActorEvent.EQUIP_ITEM_UPDATE, info);
            if (info.m_ItemNumChanged || info.m_ItemOwnerChanged)
                notice(EquipActorEvent.BAG_PAGE_NEED_CHANGE, info);
            info.m_ItemNumChanged = info.m_ItemOwnerChanged = false;
        }

        /**
         *  获取相应职业物品
         * @param job
         * @return
         *
         */
        public function getEquipByJob(job:int):Vector.<ItemInfo>
        {
            var list:Vector.<ItemInfo> = new Vector.<ItemInfo>;
            for each (var info:ItemInfo in dataList.getContent())
            {
                if (i_ItemConfig.getJobByID(info.getConfigID()) == job)
                    list.push(info);
            }
            return list;
        }

        /**
         *  获取指定心魔装备
         * @param petId心魔正数Id
         * @return
         *
         */
        public function getEquipByPetId(petId:String):Array
        {
            var equipArr:Array = [];
            for each (var info:EquipInfo in dataList.getContent())
            {
                if (info.getOwnerID() == petId)
                    equipArr.push(info);
            }
            return equipArr;
        }

        public function getEquipByHeroId(heroId:int):Array
        {
            var equipArr:Array = [];
            for each (var info:EquipInfo in dataList.getContent())
            {
                if (NumberUtility.hexaToDecimal(info.m_OwnerId) == heroId + '')
                    equipArr.push(info);
            }
            return equipArr;
        }

        public function getHeroEquip(heroId:int, pos:int):EquipInfo
        {
            var heroEquip:Array = getEquipByHeroId(heroId);
            for each (var info:EquipInfo in heroEquip)
            {
                var configInfo:ItemConfigInfo = getEquipConfigInfoById(info.getID());
                if (configInfo.equip_type == pos)
                    return info;
            }
            return null;
        }

        /**  获取装备信息         */
        public function getEquipInfoById(Id:String):EquipInfo
        {
            return dataList.get(Id);
        }

        /**  获取装备配置信息         */
        public function getEquipConfigInfoById(Id:String):ItemConfigInfo
        {
            var info:ItemConfigInfo;
            var equipInfo:EquipInfo = getEquipInfoById(Id);
            if (equipInfo)
            {
                info = i_ItemConfig.getConfigInfo(equipInfo.m_ConfigID);
            }
            return info;
        }

        /**
         *  获取佣兵装备
         * @param type EquipEnum佣兵装备了的、为装备的、所有
         * @return
         *
         */
        public function getHeroEquipList(type:int = EquipEnum.NOT_EQUIP):Vector.<EquipInfo>
        {
            var list:Vector.<EquipInfo> = new Vector.<EquipInfo>();
            for each (var info:EquipInfo in dataList.getContent())
            {
                var configInfo:ItemConfigInfo = getConfigByConfigId(info.m_ConfigID);
                if (configInfo.job <= 5)
                {
                    if (type == EquipEnum.NOT_EQUIP && !equipState(info))
                        list.push(info);
                    else if (type == EquipEnum.EQUIPED && equipState(info))
                        list.push(info);
                    else if (type == EquipEnum.ALL_EQUIP)
                        list.push(info);
                }
            }
            return list;
        }


        public function getEquipListByJob(job:int, type:int = EquipEnum.NOT_EQUIP):Vector.<EquipInfo>
        {
            var list:Vector.<EquipInfo> = new Vector.<EquipInfo>;
            var heroEquip:Vector.<EquipInfo> = getHeroEquipList();
            for each (var info:EquipInfo in dataList.getContent())
            {
                var configInfo:ItemConfigInfo = i_ItemConfig.getConfigInfo(info.m_ConfigID);
                if (configInfo.job == job)
                {
                    if (type == EquipEnum.NOT_EQUIP && !equipState(info))
                        list.push(info);
                    else if (type == EquipEnum.EQUIPED && equipState(info))
                        list.push(info);
                    else if (type == EquipEnum.ALL_EQUIP)
                        list.push(info);
                }
            }
            return list;
        }

        /**
         *装备状态
         * @param info
         * @return true装备被装备了 false装备还没有装备
         *
         */
        private function equipState(info:EquipInfo):Boolean
        {
            var ownerID:int = parseInt(info.getOwnerID(), 10);
            if (ownerID == 1 || ownerID == 2)
                return false;
            return true;
        }

        public function getEquipInfo(dbId:String):EquipInfo
        {
            for each (var info:EquipInfo in dataList.getContent())
            {
                if (info.getID() == dbId)
                    return info;
            }
            return null;
        }

        public function getEquipListByConfigId(configId:int):Vector.<EquipInfo>
        {
            var equipVec:Vector.<EquipInfo> = new Vector.<EquipInfo>();
            for each(var equipInfo:EquipInfo in dataDic)
            {
                if (equipInfo.getConfigID() == configId)
                {
                    equipVec.push(equipInfo);
                }
            }
            return equipVec;
        }

        public function getEquipInfoByPos(pos:int):EquipInfo
        {
            for each (var info:EquipInfo in dataList.getContent())
            {
                if (info.getPos() == pos)
                    return info;
            }
            return null;
        }

        public function getBagEquipCountByConfigId(configId:int):int
        {
            var count:int = 0;
            for each (var info:EquipInfo in dataList.getContent())
            {
                if (info.getConfigID() == configId && (info.getOwnerID() == CellTypeEnum.BAG || info.getOwnerID() == CellTypeEnum.STORAGE))
                    count++;
            }
            return count;
        }

        protected function notice(eventName:String, info:ItemInfo):void
        {
            dispatch(new EquipActorEvent(eventName, info));
        }
    }
}
