
import java.util.ArrayList;
import java.util.List;

import javax.swing.table.AbstractTableModel;


 

public class FinalTableModelErrorsList extends AbstractTableModel {


	private static final long serialVersionUID = 1L;
	
	private List<Error> li = new ArrayList<Error>();
    private String[] columnNames = {"Line", "Message", "Type"};

    public FinalTableModelErrorsList(List<Error> list){
         this.li = list;
  
    }

    @Override
    public String getColumnName(int columnIndex){
         return columnNames[columnIndex];
    }

    @Override     
    public int getRowCount() {
        return li.size();
    }

    @Override        
    public int getColumnCount() {
        //return 2;
    	return columnNames.length;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
    	Error e = li.get(rowIndex);
        switch (columnIndex) {
            case 0: 
                return e.getLine();
            case 1:
            	return e.getMessage();
            case 2:
            	return e.getType();
            	
           }
           return null;
   }

   @Override
   public Class<?> getColumnClass(int columnIndex){
          switch (columnIndex){
             case 0:
               return Integer.class;
             case 1:
               return String.class;
             case 2:
                 return String.class;

             }
             return null;
      }
 }