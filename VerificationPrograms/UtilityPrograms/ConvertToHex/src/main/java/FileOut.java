import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mojith on 1/19/17.
 */
public class FileOut {
    private static final String FILENAME = "/home/mojith/Projects/FYP/riscv_fpga/VerificationPrograms/UtilityPrograms/ConvertToHex/src/main/java/new.txt";

    public void writeFile(ArrayList arrayList){
        BufferedWriter bw = null;
        FileWriter fw = null;

        try {

            String content = "This is the content to write into file\n";

            fw = new FileWriter(FILENAME);
            bw = new BufferedWriter(fw);

            for(int i=0;i<arrayList.size();i++){
                bw.write(arrayList.get(i).toString());
                bw.write("\n");
            }


            System.out.println("Done");

        } catch (IOException e) {

            e.printStackTrace();

        } finally {

            try {

                if (bw != null)
                    bw.close();

                if (fw != null)
                    fw.close();

            } catch (IOException ex) {

                ex.printStackTrace();

            }

        }
    }
}
