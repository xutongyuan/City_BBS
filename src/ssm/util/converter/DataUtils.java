package ssm.util.converter;

import org.apache.commons.lang3.StringEscapeUtils;

 public class DataUtils {

    /*
     * 还原字符串
     * */
    public final static String unescapeHtml4(String origin){
        return StringEscapeUtils.unescapeHtml4(origin).replaceAll("(?i)<script>","&lt;script&gt;").replaceAll("(?i)</script>","&lt;/script&gt;")
                .replaceAll("(?i)<javascript>","&lt;javascript&gt;").replaceAll("(?i)</javascript>","&lt;/javascript&gt;")
                .replaceAll("(?i)<eval>","&lt;eval&gt;").replaceAll("(?i)</eval>","&lt;/eval&gt;");
//        return StringEscapeUtils.unescapeHtml4(origin);

    }
}
