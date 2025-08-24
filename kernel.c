void _start(void){
  const char* string = "Kernel is Working";
  char* video = (char*)0xb8000;
  int i = 0;
  while(string[i] != '\0'){
    video[ i * 2 ] = string[i];
    video[ i * 2 + 1 ] = 0x0F;
    i++;
  }
  
  while(1);
}