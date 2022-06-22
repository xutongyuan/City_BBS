package ssm;


import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.HttpRequestHandlerServlet;
import org.springframework.web.servlet.ModelAndView;
import ssm.task.TimerTasks;
import ssm.task.service.TaskService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@RestController
@RequestMapping("task")
public class TaskCtr {

	private  final Logger logger = LoggerFactory.getLogger(TaskCtr.class);

	@Autowired
	TaskService taskService;


	/*
	 * 手动触发新闻列表更新*/
	@RequestMapping(value = "/runNews",produces ="text/html;charset=utf-8")
	public String runNews(String chan, HttpSession session)
	{
		try {
			//校验管理员账号
			Object admin1 = session.getAttribute("admin");
			if(admin1==null){
				return "当前非管理员账号操作，请登录后重试";
			}
			logger.info("同步最新新闻到中间表--------------start------------------");
			int rows = taskService.addNewsTemp(chan);
			logger.info("同步新闻到中间表，共{0}条记录------end---------------------",rows);
			logger.info("自动发布新闻 start ------------------------------------");
			int postRows = taskService.autoPost();
			logger.info("发布新闻完成，共{0}条记录 end----------------------------",rows);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("新闻调度任务异常------------------------------\r\n"+e.getMessage());
			return "更新新闻失败";
		}

		return "更新新闻列表完成，请稍后刷新论坛查看结果";
	}

//	@RequestMapping(value = "/themePush",produces ="text/html;charset=utf-8")
//	public String themePush(String chan, HttpSession session)
//	{
//		try {
//			//校验管理员账号
//			Object admin1 = session.getAttribute("admin");
//			if(admin1==null){
//				return "当前非管理员账号操作，请登录后重试";
//			}
//			int postRows = taskService.ThemePush();
//			System.out.println("收录推送完成："+postRows);
//			return "收录推送完成："+postRows;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "收录推送失败";
//		}
//
//
//	}


	
	
}
