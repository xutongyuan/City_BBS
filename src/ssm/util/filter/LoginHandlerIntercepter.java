package ssm.util.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import ssm.po.Admin;
import ssm.po.Users;

public class LoginHandlerIntercepter implements HandlerInterceptor {

	 //拦截的页面
    private static final String[] IGNORE_URI={"/user/userinfo",
    	"/user/findfriend","/user/friendaddmes",
    	"/user/friendmanager","/user/postmessage",
    	"/user/inbox","/user/mailbox"};   //填写controller
    
    @Override  
    public void afterCompletion(HttpServletRequest request,  
            HttpServletResponse response, Object arg2, Exception arg3)  
            throws Exception {  
    }  
    @Override  
    public void postHandle(HttpServletRequest arg0, HttpServletResponse response,  
            Object arg2, ModelAndView arg3) throws Exception {  
          //  response.sendRedirect("/login.jsp");  
    }  
    @Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,  
            Object arg2) throws Exception {  
        //对请求路径进行判断
        String servletPath=request.getServletPath(); 
        boolean flag=true;   //用于存储判断登录的结果
        //判断请求是否需要拦截
        for(String s:IGNORE_URI){
            if(servletPath.contains(s)){
                flag=false;    //如果是拦截的网站，flag为true,跳出循环，转向下个方法
                break;
            }
        }
        //拦截请求
        if(!flag){   //如果是非公开的页面↓
        	
        
    		Users user =  (Users) request.getSession().getAttribute("data");
            if(user==null){		//判断用户是否登录
                //System.out.println("AuthorizationInterceptor拦截请求");
                //request.setAttribute("message", "请先登录管理员后再访问网站");
//                    request.getRequestDispatcher("../index.jsp").forward(request, response);
                response.sendRedirect("../index.jsp");		//重定向到首页
            }else{
                //用户登陆过，验证通过，放行
//                    System.out.println("AuthorizationInterceptor放行请求");
                flag=true;
            }
        
        }
        return flag;
    }  
}
