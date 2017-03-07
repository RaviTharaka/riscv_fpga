import java.util.ArrayList;

/**
 * Created by mojith on 2/15/17.
 */
public class ConvertCode {

    public ArrayList ConvertToHexCode(ArrayList initialCode){
        ArrayList result = new ArrayList();
        char hexLine[] = new char[8];;
        boolean hexCode = false;
        int index;

        for(int i=0;i<initialCode.size();i++){
            char tempArray[] = initialCode.get(i).toString().toCharArray();
            hexCode = false;
            index = 0;

            for(int j=0;;j++){
                if(hexCode){
                    if(tempArray[j] != '\t') {
                        hexLine[index] = tempArray[j];
                        index++;
                    }
                }
                if(tempArray[j]==':'){
                    hexCode = true;
                }
                if(index >=8){
                    break;
                }
            }

            String finalHexLine = new String(hexLine);
            result.add(finalHexLine);
        }



        return result;
    }
}
