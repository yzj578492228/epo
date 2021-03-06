package com.gzgb.epo.dao.warning;

import java.util.Map;

import com.gzgb.epo.dao.base.BaseDao;
import com.gzgb.epo.entity.ForumList;


/**
 * 
 * <pre>
 * 论坛帖子舆情DAO
 * </pre>
 * 
 * @author JiangRundong
 * @version 1.0, 2014-2-25
 */

public interface ForumListDao extends BaseDao<ForumList>{
	/**
	 * 
	 * <pre>
	 * 根据时间戳、帖子站点、帖子内容查询帖子
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            帖子站点
	 * @param content
	 *            帖子内容
	 * @param page
	 *            当前第几页
	 * @param rows
	 *            每页显示数目
	 * @param sort
	 *            按某字段排序
	 * @param order
	 *            升/降序
	 * @return
	 */
	public Map<String, Object> findForum(Integer startTime, Integer endTime,
			Integer site, String content, Integer page, Integer rows,
			String sort, String order);

}
