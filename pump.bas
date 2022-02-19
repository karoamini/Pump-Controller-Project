$regfile = "m32def.dat"
$crystal = 10000000
Config Lcd = 20 * 4
Config Lcdpin = Pin , Db7 = Portd.5 , Db6 = Portd.4 , Db5 = Portd.3 , Db4 = Portd.2 , E = Portd.1 , Rs = Portd.0


Deflcdchar [0] , 32 , 4 , 30 , 31 , 30 , 4 , 32 , 32        ' replace [x] with number (0-7)



Config Kbd = Porta , Debounce = 100 , Delay = 100

Config Sda = Portc.4
Config Scl = Portc.5
Config Portc.0 = Output                                     'khoroji
Config Portd.6 = Output                                     'backlight
Config Portd.7 = Output                                     'led motor
Config Clock = Soft
Enable Interrupts
Const Eewrite = 160
Const Eeread = 161

Dim Kbdin As Byte , Kbdin1 As Byte , San As Byte , Main As Byte , Hour As Byte , Day As Byte , Mounth As Byte , Sanb As Byte
Dim Year As Byte , Week As Byte , Password As Long , Passin As Long , Count As Byte , Newpass As Long , M As Byte
Dim Y As Byte , Y1 As Byte , A As Byte , B As Byte , Address As Word , T(8) As Byte , Addmakan As Word , K(2) As Word
Dim Ggg As Byte , Flag As Bit , Retweek As Byte , N0 As Byte , Pa As Eram Long , Sett As Byte , Test As Byte , Test1 As Byte


Cursor Off
Ggg = 100
Portd.6 = 1
'------------------------------------------------------------

For Y = 1 To 7
Cls
Locate 2 , Y : Lcd "HI-TECH" ; "     "
Waitms 50
Next Y
Cls
Waitms 200
Locate 2 , 7 : Lcd "HI-TECH" ; "     "
Waitms 500

Cls


'------------------------------------------------------------
Do
Q:
 'Locate 1 , 9 : Lcd "f" ; Flag : Lcd "s" ; Sett
'Do
'Password = Pa
'Home : Lcd "pa=" ; Pa
'Lowerline : Lcd Password;
'Loop
'===========================================================set
If Kbdin = 3 Then Goto Seet

If Sett = 1 Then
If Test = 0 Then
Cls
 Portd.6 = 0
 Display Off
Test = 1
End If
Set Portc.0
Set Portd.7
End If

If Sett = 0 And Flag = 0 Then
If Test = 1 Then
Cls
Portd.6 = 0
Display Off
Test = 0
End If
Reset Portc.0
Reset Portd.7
End If

'===========================================================
A = 1
Goto Ds1307
Up:
Kbdin = Getkbd()
Kbdin1 = Lookup(kbdin , Number)
Locate 1 , 1

If Hour < 10 Then Lcd "0"
Lcd Hour ; ":"
If Main < 10 Then Lcd "0"
 Lcd Main ; ":"
If San < 10 Then Lcd "0"
Lcd San ; "  "
Locate 2 , 1
Lcd Year ; "/"
If Mounth < 10 Then Lcd "0"
Lcd Mounth ; "/"
If Day < 10 Then Lcd "0"
Lcd Day ; "  "

'If Week = 6 Then
'Locate 2 , 13 : Lcd "jome" ; "  "


If Week = 6 And Hour = 23 And Main = 59 And San = 56 Then
Decr Retweek
If Retweek = 255 Then Retweek = 0
Wait 3
Cls
B = Low(57)
A = High(57)
I2cstart
I2cwbyte Eewrite
I2cwbyte A
I2cwbyte B
I2cwbyte Retweek
I2cstop
End If


'Elseif Week <> 6 And Week < 9 Then
'Locate 2 , 13 : Lcd "shanbe"
'End If

Locate 1 , 13 : Lcd Retweek ; "   "
Locate 1 , 16 : Lcd "WEEK"


Select Case Week
Case 1
Locate 2 , 11 : Lcd "SUNDAY"
Case 2
Locate 2 , 11 : Lcd "MONDAY"
Case 3
Locate 2 , 11 : Lcd "TUESDAY"
Case 4
Locate 2 , 11 : Lcd "WEDNESDAY"
Case 5
Locate 2 , 11 : Lcd "THURSDAY"
Case 6
Locate 2 , 11 : Lcd "FRIDAY"
Case 7
Locate 2 , 11 : Lcd "SATURDAY"
End Select




If Ggg <> Week Or M = 20 Then
Enable Interrupts
B = Low(57)
A = High(57)
I2cstart
I2cwbyte Eewrite
I2cwbyte A
I2cwbyte B
I2cstart
I2cwbyte Eeread
I2crbyte Retweek , Nack
I2cstop

'Locate 1 , 13 : Lcd Retweek ; "   "
'Locate 1 , 16 : Lcd "WEEK"


Ggg = Week : M = 0
Select Case Week
Case 1 : Addmakan = 9
Case 2 : Addmakan = 17
Case 3 : Addmakan = 25
Case 4 : Addmakan = 33
Case 5 : Addmakan = 41
Case 6 : Addmakan = 49
Case 7 : Addmakan = 1
End Select


Y1 = 20 : Goto Zread
Show:
End If

Locate 3 , 2
If T(1) < 10 Then Lcd "0"
Lcd T(1) ; ":"
If T(2) < 10 Then Lcd "0"
Lcd T(2) ; "  TO  "
If T(3) < 10 Then Lcd "0"
Lcd T(3) ; ":"
If T(4) < 10 Then Lcd "0"
Lcd T(4) ; "  "
Locate 4 , 2
If T(5) < 10 Then Lcd "0"
Lcd T(5) ; ":"
If T(6) < 10 Then Lcd "0"
Lcd T(6) ; "  TO  "
If T(7) < 10 Then Lcd "0"
Lcd T(7) ; ":"
If T(8) < 10 Then Lcd "0"
Lcd T(8) ; "  "
'Showpic 1 , 32 , Az
'Showpic 66 , 34 , Taa
'End If
'If Week <> 0 Then
'Locate 3 , 1
'If T(3) < 10 Then Lcd "0"
'Lcd T(3) ; ":"
'If T(4) < 10 Then Lcd "0"
'Lcd T(4) ; "   "
'If T(1) < 10 Then Lcd "0"
'Lcd T(1) ; ":"
'If T(2) < 10 Then Lcd "0"
'Lcd T(2) ; "   "

'Locate 4 , 1
'If T(7) < 10 Then Lcd "0"
'Lcd T(7) ; ":"
'If T(8) < 10 Then Lcd "0"
'Lcd T(8) ; "   "
'If T(5) < 10 Then Lcd "0"
'Lcd T(5) ; ":"
'If T(6) < 10 Then Lcd "0"
'Lcd T(6) ; "    "

'End If

If Retweek <> 0 Then

K(1) = T(1) * 60
K(1) = T(2) + K(1)
K(2) = T(3) * 60
K(2) = T(4) + K(2)
If T(1) <= Hour And T(2) <= Main And K(2) > K(1) And T(3) => Hour Then Flag = 1
If T(3) <= Hour And T(4) <= Main And K(2) > K(1) Then Flag = 0

K(1) = T(4) * 60
K(1) = T(5) + K(1)
K(2) = T(6) * 60
K(2) = T(7) + K(2)
If T(5) <= Hour And T(6) <= Main And K(2) > K(1) and T(7) => Hour Then Flag = 1
If T(7) <= Hour And T(8) <= Main And K(2) > K(1) Then Flag = 0


If Flag = 1 Then
If Test1 = 0 Then
Cls
 Portd.6 = 0
 Display Off
 Test1 = 1
 End If
Set Portc.0
Set Portd.7
End If


If Flag = 0 And Sett = 0 Then
If Test1 = 1 Then
Cls
 Portd.6 = 0
 Display Off
 Test1 = 0
 End If
Reset Portc.0
Reset Portd.7
End If

End If


'=======================================================================








'=======================================================================
If Kbdin = 11 Then
Set Portd.6
 Display On
Disable Interrupts
_sec = 0
Cls
M = 20
Count = 0
Passin = 0
Cls


Do

Pppp:
Locate 2 , 3 : Lcd "ENTER PASSWORD"
Locate 3 , 8 : Lcd Passin ; "      "
Kbdin = Getkbd()
If Kbdin = 16 Then Goto Pppp
If Kbdin = 12 Then
Cls : Goto Q : End If
Kbdin1 = Lookup(kbdin , Number)
Select Case Kbdin1
Case 0 To 9
Passin = Passin * 10 : Passin = Passin + Kbdin1
Incr Count
If Count => 5 Then
Count = 0
 Password = Pa
If Password < 0 Then
Password = 11111
Pa = Password
End If
If Passin = Password Then
Cls
Locate 2 , 3 : Lcd "CORRECT PASSWORD"
Waitms 600
Cls
Passin = 0
Kbdin1 = 0
Y = 1






Do
Menu:
'Locate Y , 1 : Lcd Chr(0)
Kbdin = Getkbd()
If Kbdin = 14 Then
Locate Y , 1 : Lcd " "
Y = Y + 1
If Y > 4 Then Y = 1
End If
If Kbdin = 13 Then
 Locate Y , 1 : Lcd " "

Y = Y - 1
If Y < 1 Or Y > 100 Then Y = 4


End If


If Kbdin = 12 Then
Cls : M = 20 : Goto Q : End If

 If Kbdin = 15 And Y = 1 Then Goto Barname
 If Kbdin = 15 And Y = 2 Then Goto Menu.tanzim.tairkh
 If Kbdin = 15 And Y = 3 Then Goto Zmpt
 If Kbdin = 15 And Y = 4 Then Goto Dayy
Locate 1 , 3 : Lcd "PROGRAM"
Locate 2 , 3 : Lcd "CHANGE DATE&TIME"
Locate 3 , 3 : Lcd "CHANGE PASS&BATTRY"
Locate 4 , 3 : Lcd "SET DAY"
Locate Y , 1 : Lcd Chr(0)
Loop

Else : Passin = 0 : Cls
Locate 2 , 3 : Lcd "ERROR PASSWORD"
Waitms 600
Cls
Count = 0
End If
End If


Case 30
Passin = Passin / 10
Decr Count
End Select



Loop
End If



If Kbdin < 16 Then
Cls
 _sec = 0
 Portd.6 = 1
 Display On
 End If
If _sec > 40 Then
Waitms 10                                                   'klllllllllllllllllllllllllllllllllllllll
 Portd.6 = 0
 Display Off
 End If



 Loop
 End





Ds1307:
I2cstart                                                    ' Generate start code
I2cwbyte &HD0                                               ' send address
I2cwbyte 0                                                  ' start address in 1307
I2cstart                                                    ' Generate start code
I2cwbyte &HD1                                               ' send address
I2crbyte San , Ack
I2crbyte Main , Ack
I2crbyte Hour , Ack
I2crbyte Week , Ack
I2crbyte Day , Ack
I2crbyte Mounth , Ack
I2crbyte Year , Nack
I2cstop
Hour = Makedec(hour)
Main = Makedec(main)
San = Makedec(san)
Day = Makedec(day)
Mounth = Makedec(mounth)
Year = Makedec(year)
Week = Makedec(week)
Waitms 10
Select Case A
Case 1 : Goto Up
Case 2 : Goto Up0
Case 3 : Goto Up1
Case 4 : Goto Up2
End Select

Number:
'Data 10 , 20 , 30 , 40 , 3 , 6 , 9 , 50 , 2 , 5 , 8 , 0 , 1 , 4 , 7 , 60
Data 1 , 4 , 7 , 60 , 2 , 5 , 8 , 0 , 3 , 6 , 9 , 50 , 10 , 20 , 30 , 40



Zwrite:
Cls
Locate 2 , 5 : Lcd "PLEASE WAIT" ; "              "

K(1) = Addmakan + 7
For Address = Addmakan To K(1)
K(2) = K(1) - Address
K(2) = 8 - K(2)
B = Low(address)
A = High(address)
I2cstart
I2cwbyte Eewrite
I2cwbyte A
I2cwbyte B
I2cwbyte T(k(2))
I2cstop
Waitms 100
Next
Cls
Locate 2 , 8 : Lcd "save" ; "          "
Waitms 100
Cls
Goto Barname



Zread:
If Y1 <> 20 Then
Cls
Locate 2 , 5 : Lcd "PLEASE WAIT" ; "              "
End If
K(1) = Addmakan + 7
For Address = Addmakan To K(1)
K(2) = K(1) - Address
K(2) = 8 - K(2)
B = Low(address)
A = High(address)
I2cstart
I2cwbyte Eewrite
I2cwbyte A
I2cwbyte B
I2cstart
I2cwbyte Eeread
I2crbyte T(k(2)) , Nack
I2cstop
Waitms 100
Next

If Y1 = 20 Then Goto Show
 Cls
Goto Rozha



Tanz_karkhane:
Cls
Locate 2 , 5 : Lcd "PLEASE WAIT" ; "              "
Do
For Address = 0 To 511
B = Low(address)
A = High(address)
I2cstart
I2cwbyte Eewrite
I2cwbyte A
I2cwbyte B
I2cwbyte 0
I2cstop
Waitms 50
Next

Kbdin = 0 : Kbdin1 = 0 : San = 0 : Main = 0 : Hour = 0 : Day = 0 : Mounth = 0
Year = 0 : Week = 1 : Passin = 0 : Count = 0 : Newpass = 0 : M = 0
Y = 0 : Y1 = 0 : A = 0 : B = 0 : Address = 0 : T(8) = 0 : Addmakan = 0 : K(2) = 0
Ggg = 0 : Flag = 0 : Retweek = 1
Password = 12345 : Pa = Password : Password = 12345


Cls
Goto Zmpt
Loop


Rozha:
Retweek = T(1)
Rozha1:

Do
Locate 1 , 2
Select Case Addmakan
Case 1
Locate 1 , 1 : Lcd "SATURDAY"
Case 9
Locate 1 , 1 : Lcd "SUNDAY"
Case 17
Locate 1 , 1 : Lcd "MONDAY"
Case 25
Locate 1 , 1 : Lcd "TUESDAY"
Case 33
Locate 1 , 1 : Lcd "WEDNESDAY"
Case 41
Locate 1 , 1 : Lcd "THURSDAY"
Case 49
Locate 1 , 1 : Lcd "FRIDAY"
Case 57
Locate 1 , 1 : Lcd "WEEK"
End Select



'If Addmakan > 0 And Addmakan < 50 Then


If Addmakan < 50 Then
Select Case Count
Case 1 : Locate 3 , 3
Case 2 : Locate 3 , 6
Case 3 : Locate 3 , 11
Case 4 : Locate 3 , 14
Case 5 : Locate 4 , 3
Case 6 : Locate 4 , 6
Case 7 : Locate 4 , 11
Case 8 : Locate 4 , 14
End Select
Lcd "  "


Waitms 100
Locate 3 , 3
If T(1) < 10 Then Lcd "0"
Lcd T(1) ; ":"
If T(2) < 10 Then Lcd "0"
Lcd T(2) ; "   "
If T(3) < 10 Then Lcd "0"
Lcd T(3) ; ":"
If T(4) < 10 Then Lcd "0"
Lcd T(4) ; "    "
Locate 4 , 3
If T(5) < 10 Then Lcd "0"
Lcd T(5) ; ":"
If T(6) < 10 Then Lcd "0"
Lcd T(6) ; "   "
If T(7) < 10 Then Lcd "0"
Lcd T(7) ; ":"
If T(8) < 10 Then Lcd "0"
Lcd T(8) ; "    "
'Showpic 1 , 32 , Az
'Showpic 66 , 34 , Taa
End If

If Addmakan > 49 And Addmakan < 58 Then
Locate 3 , 5 : Lcd Retweek ; "    "
End If



A = 2 : Goto Ds1307
Up0:
Locate 1 , 10
If Hour < 10 Then Lcd "0"
Lcd Hour ; ":"
If Main < 10 Then Lcd "0"
 Lcd Main ; ":"
If San < 10 Then Lcd "0"
Lcd San ; "    "
'LOOP

Kbdin = Getkbd()
If Kbdin = 16 Then Goto Rozha1
Kbdin1 = Lookup(kbdin , Number)

If Addmakan > 49 And Addmakan < 58 Then
Select Case Kbdin1
Case 0 To 9
Passin = Passin * 10 : Passin = Passin + Kbdin1
End Select
If Passin > 250 Then Passin = 0

 '-------------------------------------------------------------------------clear week
If Kbdin1 = 30 Then
Passin = Passin / 10
End If

Retweek = Passin


  '-------------------------------------------------------------------------------




If Kbdin1 = 10 Then
Passin = 0 : Retweek = 1 : Cls : Goto Barname
End If

If Kbdin1 = 40 Then
M = 20
Passin = 0 : T(1) = Retweek : Goto Zwrite
End If

End If

If Addmakan < 50 Then
Select Case Kbdin1
Case 0 To 9
Passin = Passin * 10 : Passin = Passin + Kbdin1
If Count = 1 Or Count = 3 Or Count = 5 Or Count = 7 Then
If Passin < 24 Then
 T(count) = Passin
 Else
 T(count) = 0 : Passin = 0
End If
Else
If Passin < 60 Then
 T(count) = Passin
 Else
 T(count) = 0 : Passin = 0
End If
End If
Case 30
Incr Count
Passin = 0
If Count > 8 Then Count = 1
Case 20
Passin = 0
Decr Count
If Count < 1 Then Count = 8
Case 40
M = 30
Goto Zwrite
Case 10
Passin = 0 : Cls : Goto Barname
End Select
End If

Loop


Zmpt:
'DO
Y = 1
Waitms 100
Cls

Q1:

Kbdin = Getkbd()
If Kbdin = 14 Then
Locate Y , 1 : Lcd " "
Incr Y
If Y > 3 Then Y = 1
End If
Waitus 500
If Kbdin = 13 Then
Locate Y , 1 : Lcd " "
Decr Y
If Y < 1 Or Y > 100 Then Y = 3
End If

Locate Y , 1 : Lcd Chr(0)
Locate 1 , 3 : Lcd "SET BATTRY"
Locate 2 , 3 : Lcd "CHANGE PASS"
Locate 3 , 3 : Lcd "MASTER RESET"

If Kbdin = 16 Or Kbdin = 14 Or Kbdin = 13 Then Goto Q1
If Kbdin = 15 And Y = 3 Then Goto Tanz_karkhane
If Kbdin = 12 Then
 Count = 0
Goto Menu
End If

If Kbdin = 15 And Y = 1 Then
Cls
        M = Makebcd(9)
        I2cstart
        I2cwbyte &HD0
        I2cwbyte 0
        I2cwbyte 0
        I2cwbyte 0
        I2cwbyte M
        I2cwbyte 4
        I2cstop
 Locate 2 , 8 : Lcd "save" ; "          "
  Wait 1
  Cls
  Goto Q
  End If



If Kbdin = 15 And Y = 2 Then
Changepass:
Kbdin1 = 0
Kbdin = 0
Count = 0
Newpass = 0
Cls
Passin = 0
Do
Ssss:
Locate 1 , 1 : Lcd "ENTER PASS"
Locate 2 , 1 : Lcd Newpass ; "              "
Kbdin = Getkbd()
If Kbdin = 16 Then Goto Ssss
Kbdin1 = Lookup(kbdin , Number)
Select Case Kbdin1
Case 0 To 9
If Count < 5 Then
Newpass = Newpass * 10 : Newpass = Newpass + Kbdin1
 Incr Count
 End If
 Case 40
 If Newpass > 9999 Then
 Password = Newpass : Count = 0
 Pa = Password
 Cls
 Locate 2 , 8 : Lcd "save" ; "          "
 Waitms 300
 Cls
 Goto Menu
 End If

Case 10
Cls

Case 30
Newpass = Newpass / 10
Decr Count
If Count = 255 Then Count = 0
End Select
Loop
End If
'Loop

'///////////////////////////////////////////////////////////////
Barname:


Cls
Y = 1
Y1 = 1
Do


If Y1 = 1 Then

Locate 1 , 3 : Lcd "SATURDAY "
Locate 2 , 3 : Lcd "SUNDAY  "
Locate 3 , 3 : Lcd "MONDAY"
Locate 4 , 3 : Lcd "TUESDAY"


Elseif Y1 = 2 Then
Locate 1 , 3 : Lcd "WEDNESDAY"
Locate 2 , 3 : Lcd "THURSDAY"
Locate 3 , 3 : Lcd "FRIDAY"
Locate 4 , 3 : Lcd "WEEK  "

Elseif Y1 > 2 Then
 Y1 = 1
End If

Kbdin = Getkbd()
Kbdin1 = Lookup(kbdin , Number)

If Kbdin1 = 30 Then
Locate Y , 1 : Lcd " "
 Incr Y : End If

If Y1 = 2 And Y > 4 Then
Y1 = 1
Y = 1
Cls
End If
If Y > 4 Then
Incr Y1
Y = 1
Cls

End If

If Kbdin1 = 20 Then
Locate Y , 1 : Lcd " "
 Y = Y - 1
 End If
If Y < 1 Or Y > 200 Then
 Y = 4
Decr Y1
If Y1 < 1 Then
Y1 = 2
Y = 4
End If
Cls
End If

If Kbdin1 = 40 Then
Cls
Count = 1
Select Case Y1
Case 1
If Y = 1 Then Addmakan = 1
If Y = 2 Then Addmakan = 9
If Y = 3 Then Addmakan = 17
If Y = 4 Then Addmakan = 25
Case 2

If Y = 1 Then Addmakan = 33
If Y = 2 Then Addmakan = 41
If Y = 3 Then Addmakan = 49
If Y = 4 Then Addmakan = 57

End Select


Goto Zread
End If

If Kbdin1 = 10 Then
Cls : Goto Menu
End If
Locate Y , 1 : Lcd Chr(0)
Loop


Menu.tanzim.tairkh:
Cls
Y = 1
Do

Kbdin = Getkbd()
Kbdin1 = Lookup(kbdin , Number)

If Kbdin = 14 Then
Incr Y
End If

If Y > 2 Then Y = 1
If Kbdin = 13 Then Decr Y
If Y < 1 Or Y > 100 Then Y = 2




 If Kbdin = 15 And Y = 1 Then
 Cls
 Goto Saat
  End If
 If Kbdin = 15 And Y = 2 Then
 Cls
 Goto Tarikh
  End If


 If Kbdin = 12 Then Goto Menu

 Locate 1 , 1 : Lcd " "
 Locate 2 , 1 : Lcd " "



Locate Y , 1 : Lcd Chr(0)

Locate 1 , 3 : Lcd "CHANGE TIME     "                       'Showpic 75 , 4 , Shanbe
Locate 2 , 3 : Lcd "CHANGE DATE "                           'Showpic 75 , 26 , Shanbe
'Locate 3 , 3 : Lcd "day"                                    'Showpic 110 , 24 , 1

Loop



Saat:
A = 3 : Goto Ds1307
Count = 0
Up1:

Do
Locate 1 , 1 : Lcd "CHANGE TIME"

If Count = 0 Then Locate 4 , 3
If Count = 1 Then Locate 4 , 6
Lcd "  "
Waitms 100
Locate 4 , 3
If Hour < 10 Then Lcd "0"
Lcd Hour ; ":"
If Main < 10 Then Lcd "0"
 Lcd Main ; ":"
If San < 10 Then Lcd "0"
Lcd San ; ""
Kbdin = Getkbd()
If Kbdin = 16 Then Goto Up1
Kbdin1 = Lookup(kbdin , Number)
Select Case Kbdin1
Case 0 To 9
Passin = Passin * 10 : Passin = Passin + Kbdin1
If Count = 0 And Passin < 24 Then
 Hour = Passin
 Elseif Count = 0 And Passin > 23 Then
  Passin = 0
 End If
 If Count = 1 And Passin < 60 Then
 Main = Passin
 Elseif Count = 1 And Passin > 59 Then
  Passin = 0
 End If


Case 30
Passin = 0
Incr Count
If Count > 1 Then Count = 0
Case 40
Hour = Makebcd(hour)
Main = Makebcd(main)
I2cstart
I2cwbyte &HD0
I2cwbyte 1
I2cwbyte Main
I2cwbyte Hour
I2cstop
Hour = Makedec(hour)
Main = Makedec(main)
Count = 0 : Passin = 0
Cls
Locate 2 , 8 : Lcd "save" ; "          "
Waitms 100
Cls
Goto Menu.tanzim.tairkh
Case 20
Passin = 0
Decr Count
If Count = 255 Then Count = 0
Case 10
Count = 0 : Passin = 0
Cls

Goto Menu.tanzim.tairkh
End Select
Loop




Tarikh:
A = 4 : Goto Ds1307
Count = 0
Up2:

Do
Locate 1 , 1 : Lcd "CHANGE DATE"
If Count = 0 Then Locate 3 , 3
If Count = 1 Then Locate 3 , 6
If Count = 2 Then Locate 3 , 9
Lcd "  "
Waitms 100
Locate 3 , 3
If Year < 10 Then Lcd "0"
Lcd Year ; "/"
If Mounth < 10 Then Lcd "0"
 Lcd Mounth ; "/"
If Day < 10 Then Lcd "0"
Lcd Day ; ""
Kbdin = Getkbd()
If Kbdin = 16 Then Goto Up2
Kbdin1 = Lookup(kbdin , Number)
Select Case Kbdin1
Case 0 To 9
Passin = Passin * 10 : Passin = Passin + Kbdin1
If Count = 0 And Passin < 100 Then
 Year = Passin
 Elseif Count = 0 And Passin > 99 Then
  Passin = 0
 End If
 If Count = 1 And Passin < 13 Then
 Mounth = Passin
 Elseif Count = 1 And Passin > 12 Then
  Passin = 0
 End If

 If Count = 2 And Passin < 31 Then
 Day = Passin
 Elseif Count = 2 And Passin > 30 Then
  Passin = 0
 End If


Case 30


Passin = 0
Incr Count
If Count > 2 Then Count = 0
Case 40
Cls


Day = Makebcd(day)
Year = Makebcd(year)
Mounth = Makebcd(mounth)
I2cstart
I2cwbyte &HD0
I2cwbyte 4
I2cwbyte Day
I2cwbyte Mounth
I2cwbyte Year
I2cstop
Day = Makedec(day)
Year = Makedec(year)
Mounth = Makedec(mounth)
Count = 0 : Passin = 0
Locate 2 , 8 : Lcd "save" ; "          "
Waitms 200

Cls
Goto Menu.tanzim.tairkh

Case 20
Passin = 0
Decr Count
If Count = 255 Then Count = 2
Case 10
Count = 0 : Passin = 0
Cls
Goto Menu.tanzim.tairkh
End Select
Loop








Dayy:
Cls
Y = 1
Y1 = 1
Q2:
Do

Locate Y , 1 : Lcd Chr(0)
If Y1 = 1 Then
Locate 1 , 3 : Lcd "SATURDAY "                              'Showpic 75 , 4 , Shanbe
Locate 2 , 3 : Lcd "SUNDAY   "                              'Showpic 75 , 26 , Shanbe
Locate 3 , 3 : Lcd "MONDAY   "                              'Showpic 110 , 24 , 1
Locate 4 , 3 : Lcd "TUESDAY  "


Elseif Y1 = 2 Then
Locate 1 , 3 : Lcd "WEDNESDAY"                              'Showpic 75 , 4 , Shanbe
Locate 2 , 3 : Lcd "THURSDAY "                              'Showpic 75 , 26 , Shanbe
Locate 3 , 3 : Lcd "FRIDAY   "                              'Showpic 110 , 24 , 1
'Locate 4 , 3 : Lcd "tekrar  hafte     "

Elseif Y1 > 2 Then
Y1 = 1
End If



Kbdin = Getkbd()
If Kbdin = 16 Then Goto Q2
'Kbdin1 = Lookup(kbdin , Number)


If Kbdin = 14 Then
Locate Y , 1 : Lcd " "
Incr Y
End If
If Y1 = 2 And Y > 3 Then
Y1 = 1
Y = 1
Cls
End If
If Y > 4 Then
Incr Y1
Y = 1
Cls

End If

If Kbdin = 13 Then
Locate Y , 1 : Lcd " "
Decr Y
End If

If Y < 1 Or Y > 200 Then
 Y = 4
Decr Y1
If Y1 < 1 Or Y1 > 200 Then
Y1 = 2
Y = 3
End If
Cls
End If


Select Case Y1
Case 1
If Y = 1 Then M = 7
If Y = 2 Then M = 1
If Y = 3 Then M = 2
If Y = 4 Then M = 3
Case 2

If Y = 1 Then M = 4
If Y = 2 Then M = 5
If Y = 3 Then M = 6
End Select


'Kbdin = Getkbd()
'Kbdin1 = Lookup(kbdin , Number)

If Kbdin = 15 Then
Cls
Locate 2 , 8 : Lcd "save" ; "          "
Waitms 100
M = Makebcd(m)
I2cstart
I2cwbyte &HD0
I2cwbyte 3
I2cwbyte M
I2cstop
Y = 4
Cls

Goto Menu
End If
If Kbdin = 12 Then
Y = 1
Goto Menu
Cls
End If

Loop







Seet:
Kbdin = 0
Kbdin1 = 0
Passin = 0
Cls
Do

Ppppp:
Locate 2 , 3 : Lcd "ENTER PASSWORD"
Locate 3 , 8 : Lcd Passin ; "      "
Kbdin = Getkbd()
If Kbdin = 16 Then Goto Ppppp
If Kbdin = 12 Then
Cls : M = 20 : Goto Q : End If
Kbdin1 = Lookup(kbdin , Number)
Select Case Kbdin1
Case 0 To 9
Passin = Passin * 10 : Passin = Passin + Kbdin1
Incr Count
If Count => 5 Then
Count = 0
 Password = Pa
If Passin = Password Then
Cls
Locate 2 , 3 : Lcd "CORRECT PASSWORD"
Incr Sett
If Sett > 1 Then Sett = 0
Waitms 500


Else : Passin = 0 : Cls
Locate 2 , 3 : Lcd "ERROR PASSWORD"
Waitms 600
Goto Ppppp
End If
Cls
Passin = 0
Kbdin1 = 0
M = 20
Goto Q
End Select
End If
'End If

 Loop

M = 20
Cls
Goto Q