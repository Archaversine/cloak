# Cloak 

Encrypt your files by turning them invisible! (Note: this is not a secure 
encryption method, it's just funny.)

## Example Encryption

File Contents:

``` 
Hello, World!
```

Encryption Command:

```bash 
$ cloak encrypt input.txt output.txt
```

Encrypted File Contents:

```
   
  
                                                         
 
  

                                                           

 

                                                           

 

                                                         



 

                                                           

 
                                                               
                                                          


 
 
                                                         



 

                                                          
  


                                                           

 

                                                           
  

                                                         
    
                                                           
 
                                                            
```

(Yes, this is the entire contents of the file.)

## Example Decryption

Command: 

```bash 
$ cloak reveal output.txt revealed.txt
```

Decrypted File Contents:

```
Hello, World!
```
