import processing.serial.*;
import processing.net.*;
Serial p;
Server s;
Client c;
void setup() {
  s = new Server(this, 12345);
  p = new Serial(this, "COM7", 9600);
}
String msg;
void draw() {
  c = s.available();
  if (c!=null) {
    String m = c.readString();
    if (m.indexOf("PUT")==0) {
      int n = m.indexOf("\r\n\r\n")+4;
      m = m.substring(n);
      m += '\n';
      p.write(m);
    } 
    else {
      c.write("HTTP/1.1 200 OK\r\n\r\n"); // POST 규격
      c.write(msg);
    }
    c.stop();
  }
  if (p.available()>0) {
    String m = p.readString();
    if (m!=null) {
      msg = m;
    }
  }
}
