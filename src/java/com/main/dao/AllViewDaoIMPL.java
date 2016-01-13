/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.main.dao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author krisnela
 */
@Transactional
@Repository
public class AllViewDaoIMPL implements AllViewDao{
    @Autowired SessionFactory sessionfactory;

    JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    @Override
    public List getanyhqldatalist(String query) {
        try {
            return sessionfactory.getCurrentSession().createQuery(query).list();
        } catch (Exception e) {
            e.printStackTrace();
            return sessionfactory.getCurrentSession().createQuery(query).list();
        }
        
    }

    @Override
    public Object getspecifichqldata(Class clazz, Object pk) {
        return(Object) sessionfactory.getCurrentSession().get(clazz, (Serializable) pk);
    }

    @Override
    public List<Map<String,Object>> getanyjdbcdatalist(String query) {
        return jdbcTemplate.queryForList(query);
    }

    @Override
    public int Get_Record_Count(String query){
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list = jdbcTemplate.queryForList(query);
        if(list != null)
        {
            return list.size();
        }
        else
        {
            return 0;
        }
    }
   
    @Override
    public int Get_Page_Count(String query, int PageSize){
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list = jdbcTemplate.queryForList(query);
        int PageCnt = 0;
        if(list != null)
        {
            PageCnt = list.size()/PageSize;
            
            int mod = list.size()%PageSize;
            
            if(mod > 0)
                PageCnt = PageCnt + 1;
        }
        return PageCnt;
    }
    
}
