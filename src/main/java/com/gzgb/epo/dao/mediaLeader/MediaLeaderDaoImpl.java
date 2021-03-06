package com.gzgb.epo.dao.mediaLeader;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.QueryException;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.gzgb.epo.dao.base.BaseDaoImpl;
import com.gzgb.epo.entity.CityRegion;
import com.gzgb.epo.entity.MediaLeader;

/**
 * 
 * <pre>
 * 主流媒体类DaoImpl
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-25
 */
@Repository
public class MediaLeaderDaoImpl extends BaseDaoImpl<MediaLeader> implements
		MediaLeaderDao {

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getAllWithList(final Map<String, String> mapString,
			final Map<String, Byte> mapByte, final Map<String, Integer> mapInt,
			final Map<String, Long> mapLong, final List<CityRegion> cityRegionList, Integer page, Integer rows,
			String sort, String order) throws QueryException {
		try {
			Criteria c = getSession().createCriteria(MediaLeader.class);
			if (mapString != null && mapString.keySet() != null) {
				Iterator it = mapString.keySet().iterator();
				while (it.hasNext()) {
					String property = (String) it.next();
					String value = (String) mapString.get(property);
					if (value != null && !"".equals(value.trim())) {
						value = "%" + value + "%";
						c.add(Restrictions.like(property, value));
					}
				}
			}
			if (mapByte != null && mapByte.keySet() != null) {
				Iterator it = mapByte.keySet().iterator();
				while (it.hasNext()) {
					String property = (String) it.next();
					Byte value = (Byte) mapByte.get(property);
					if (value != null) {
						c.add(Restrictions.eq(property, value));
					}
				}
			}
			if (mapInt != null && mapInt.keySet() != null) {
				Iterator it = mapInt.keySet().iterator();
				while (it.hasNext()) {
					String property = (String) it.next();
					Integer value = (Integer) mapInt.get(property);
					if (value != null) {
						c.add(Restrictions.eq(property, value));
					}
				}
			}
			if (mapLong != null && mapLong.keySet() != null) {
				Iterator it = mapLong.keySet().iterator();
				while (it.hasNext()) {
					String property = (String) it.next();
					Long value = (Long) mapLong.get(property);
					if (value != null) {
						c.add(Restrictions.eq(property, value));
					}
				}
			}
			if(cityRegionList != null){
				c.add(Restrictions.in("regionId", cityRegionList));
			}
			List<MediaLeader> list = c.list();
			int total = 0;
			if (list != null) {
				total = list.size();
			}
			if (page == null || page == 0) {
				page = 1;
			}
			if (rows == null || rows == 0) {
				rows = 10;
			}
			if (sort != null && order != null) {
				if ("asc".equals(order)) {
					c.addOrder(Order.asc(sort));
				} else {
					c.addOrder(Order.desc(sort));
				}
			} else {
				// 默认按照ID升序排序
				c.addOrder(Order.asc("id"));
			}
			List<MediaLeader> objList = c.setFirstResult((page - 1) * rows)
					.setMaxResults(rows).list();
			Map<String, Object> returnMap = new HashMap<String, Object>();
			if (objList != null && objList.size() > 0) {
				returnMap.put("total", total);
				returnMap.put("rows", objList);
				return returnMap;
			} else {
				returnMap.put("total", total);
				returnMap.put("rows", "");
				return returnMap;
			}

		} catch (QueryException ex) {
			throw ex;
		}
	}

}
