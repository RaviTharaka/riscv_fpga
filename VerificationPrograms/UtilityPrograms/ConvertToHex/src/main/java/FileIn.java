import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mojith on 1/19/17.
 */
public class FileIn {

    //BufferedReader br = null;
    //FileReader fr = null;
    StringBuilder sb = new StringBuilder();
    BufferedReader br = null;

    public ArrayList readFile(){
        ArrayList arrayList = new ArrayList();
        try {
            br = new BufferedReader(new FileReader("/home/mojith/Projects/FYP/riscv_fpga/VerificationPrograms/UtilityPrograms/ConvertToHex/src/main/java/test.txt"));
            String line;
            while ((line = br.readLine()) != null) {
                /*if (sb.length() > 0) {
                    sb.append("\n");
                }
                sb.append(line);*/
                arrayList.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (br != null) {
                    br.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        //String contents = sb.toString();
        //System.out.println(arrayList);
        return  arrayList;
    }

}
