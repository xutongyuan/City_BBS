package ssm.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import ssm.task.service.TaskService;

@Service
@EnableScheduling
public class TimerTasks {

    private  final Logger logger = LoggerFactory.getLogger(TimerTasks.class);

    @Autowired
    TaskService taskService;
    @Scheduled(cron="0 0 0,2,4,6,8,10,12,14,16,18,20,22 * * ? ")  	 // 每2小时更新一次
    public void newsTask(){
        try {
            //要执行的任务逻辑写在这里
            logger.info("同步最新新闻到中间表--------------start------------------");
            int rows = taskService.addNewsTemp(null);
            logger.info("同步新闻到中间表，共{0}条记录------end---------------------",rows);
            logger.info("自动发布新闻 start ------------------------------------");
            int postRows = taskService.autoPost();
            logger.info("发布新闻完成，共{0}条记录 end----------------------------",rows);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("新闻调度任务异常------------------------------\r\n"+e.getMessage());
        }
    }
}

