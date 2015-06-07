
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.util.List;

import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;

public class ErrorsPanel extends JPanel {

	private static final long serialVersionUID = 1L;
	private JScrollPane listScroller;
	
	public ErrorsPanel(List<Error> errorsList){
		
		super();
		this.setLayout(new BorderLayout());
		
		//TABLE OF FRIENDS
		JTable jTable1 = new javax.swing.JTable();
		jTable1.setModel(new FinalTableModelErrorsList(errorsList));
		jTable1.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
		jTable1.getColumnModel().getColumn(0).setPreferredWidth(70);
		jTable1.getColumnModel().getColumn(0).setMaxWidth(70);
		jTable1.getColumnModel().getColumn(1).setMinWidth(600);
		jTable1.getColumnModel().getColumn(2).setPreferredWidth(100);
		jTable1.getColumnModel().getColumn(2).setMaxWidth(100);
		
		//add scroll
		listScroller = new JScrollPane(jTable1);
		//Dimension d = new Dimension(width,height);
		//listScroller.setPreferredSize(d);
		this.add(listScroller, BorderLayout.NORTH);

	}
	
	void setDimension(int width, int height){
		Dimension d = new Dimension(width,height);
		listScroller.setPreferredSize(d);
	}
}
