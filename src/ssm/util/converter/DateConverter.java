package ssm.util.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.core.convert.converter.Converter;

public class DateConverter implements Converter<String, Date> {
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Override
	public Date convert(String arg0) {
		// TODO Auto-generated method stub
		
		try {
			if(arg0==null || arg0.equals(""))
				return null;
			Date d=sdf.parse(arg0);
			return d;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String toString(Date d)
	{
		if(d==null)
			return "";
		return sdf.format(d);
	}



}
