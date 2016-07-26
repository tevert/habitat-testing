import java.net.*;
import java.io.*;

public class Main {
	public static void main(String[] args) throws Exception {
		try {
			ServerSocket server = new ServerSocket(80);
			while(true) {
				Socket client = server.accept();
				client.getOutputStream().write("Hello world!".getBytes());
			}
		} catch (IOException e) {
			throw new Exception(e);
		}
	}
}
