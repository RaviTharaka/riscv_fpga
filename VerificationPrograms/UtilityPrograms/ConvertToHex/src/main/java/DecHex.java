import java.util.ArrayList;

/**
 * Created by mojith on 4/1/17.
 */
public class DecHex {

    public String toHex(String string){
        String output = "00000000";
        switch (string.length()) {
            case 1:
                output = "0000000"+string;
                break;
            case 2:
                output = "000000"+string;
                break;
            case 3:
                output = "00000"+string;
                break;
            case 4:
                output = "0000"+string;
                break;
            case 5:
                output = "000"+string;
                break;
            case 6:
                output = "00"+string;
                break;
            case 7:
                output = "0"+string;
                break;
            default:
                output = string;
                break;
        }
        return output;
    }



    public ArrayList ConvertToHexCode(ArrayList initialCode){
        ArrayList result = new ArrayList();


        for(int i=0;i<initialCode.size();i++){
            String temp = initialCode.get(i).toString();
            int tempInt = Integer.parseInt(temp);
            String str = Integer.toHexString(tempInt);
            result.add(toHex(str));
        }
        /*System.out.println(temp);
        System.out.println(tempInt);
        System.out.println(str);*/
        return result;
    }
}
