package com.gzgb.epo.dao.messageCountChange;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.QueryException;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.gzgb.epo.dao.base.BaseDaoImpl;
import com.gzgb.epo.entity.MessageCountChange;

/**
 * 
 * <pre>
 * 舆论领袖言论转载或发布量变化DaoImpl
 * </pre>
 * 
 * @author Administrator
 * @version 1.0, 2014-2-25
 */
@Repository
public class MessageCountChangeDaoImpl extends BaseDaoImpl<MessageCountChange>
		implements MessageCountChangeDao {

	/**
	 * 
	 * <pre>
	 * 根据社交账号获得记录
	 * </pre>
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<MessageCountChange> findByNetWorkId(Long id)
			throws QueryException {
		try {
			Criteria criteria = getSession().createCriteria(
					MessageCountChange.class);
			criteria.add(Restrictions.eq("mediaLeaderId.id", id));
			criteria.addOrder(Order.asc("time"));
			List<MessageCountChange> list = criteria.list();
			if (list.size() == 0) {
				return null;
			}
			return list;
		} catch (QueryException qe) {
			throw qe;
		}
	}
	
	/**
	 * 
	 * <pre>
	 *  通过netWorkid 类型 ，找出特定月份的记录
	 * </pre>
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<MessageCountChange> findByidAndtimeAndtype(List<Integer> startAndEnd, Long networkid, String type)
			throws QueryException {
		try {
			Criteria criteria = getSession().createCriteria(MessageCountChange.class);
			criteria.add(Restrictions.eq("mediaLeaderId.id", networkid));
			criteria.add(Restrictions.between("time", startAndEnd.get(0), startAndEnd.get(1)));
			criteria.add(Restrictions.eq("type", type));
			List<MessageCountChange> list = criteria.list();
			if (list.size() == 0 || list == null) {
				return null;
			}
			return list;
		} catch (QueryException qe) {
			throw qe;
		}
	}
}
