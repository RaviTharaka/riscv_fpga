import java.util.ArrayList;
import java.util.Scanner;

/**
 * Created by mojith on 1/19/17.
 */
public class RiscVBase {
    public static void main(String args[]){
        String temp = "fe010113";

        HexBin hexBin = new HexBin();

        String newTemp = hexBin.toBin(temp);
        System.out.println(newTemp);


        FileIn fileIn =new FileIn();
        ArrayList arrayList = new ArrayList();
        arrayList = fileIn.readFile();
        //System.out.println(arrayList.get(0));


        /*
        * ****************************************
        * Generate hex code from the initial file
        * */
        ConvertCode convertCode = new ConvertCode();
        ArrayList hexCode = convertCode.ConvertToHexCode(arrayList);
        System.out.println(hexCode.get(0));
        System.out.println(hexCode.get(1));
        System.out.println(hexCode.get(2));

        FileOut fileOut = new FileOut();
        fileOut.writeFile(hexCode);
        /*****************************************************************/



        //int size = arrayList.size();
        /*for(int i=0;i<size;i++){
            System.out.println(hexBin.toBin(arrayList.get(i).toString()));
        }*/
        /*ArrayList binList = new ArrayList();
        binList = hexBin.toBinList(arrayList);

        int size = binList.size();
        for(int i=0;i<size;i++){
            System.out.println(binList.get(i).toString());
        }


        FileOut fileOut = new FileOut();
        fileOut.writeFile(arrayList);*/

    }
}
