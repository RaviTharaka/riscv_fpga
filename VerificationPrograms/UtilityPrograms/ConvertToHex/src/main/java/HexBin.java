import java.util.ArrayList;

/**
 * Created by mojith on 1/19/17.
 */
public class HexBin {

    public ArrayList toBinList(ArrayList initialList){
        ArrayList finalList = new ArrayList();
        for(int i=0;i<initialList.size();i++){
            finalList.add(toBin(initialList.get(i).toString()));
        }
        return finalList;
    }


    public String toBin(String string){
        String binary;
        String result = "";
        char array[] = string.toCharArray();

        for(int i=0;i<string.length();i++){
            switch (array[i]){
                case '0':
                    binary = "0000";
                    break;
                case '1':
                    binary = "0001";
                    break;
                case '2':
                    binary = "0010";
                    break;
                case '3':
                    binary = "0011";
                    break;
                case '4':
                    binary = "0100";
                    break;
                case '5':
                    binary = "0101";
                    break;
                case '6':
                    binary = "0110";
                    break;
                case '7':
                    binary = "0111";
                    break;
                case '8':
                    binary = "1000";
                    break;
                case '9':
                    binary = "1001";
                    break;
                case 'a':
                    binary = "1010";
                    break;
                case 'b':
                    binary = "1011";
                    break;
                case 'c':
                    binary = "1100";
                    break;
                case 'd':
                    binary = "1101";
                    break;
                case 'e':
                    binary = "1110";
                    break;
                case 'f':
                    binary = "1111";
                    break;
                default:
                    binary = "";
            }
            result+=binary;
        }
        return result;
    }

}
