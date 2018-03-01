;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (Mac OS X x86_64)
;--------------------------------------------------------
	.module rtc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _DS1307Write
	.globl _DS1307Read
	.globl _mktime
	.globl _localtime
	.globl _SoftI2CReadByte
	.globl _SoftI2CWriteByte
	.globl _SoftI2CStop
	.globl _SoftI2CStart
	.globl _SoftI2CInit
	.globl _dayTime
	.globl _RTC_Init
	.globl _RTC_GetDateTime
	.globl _RTC_SetDateTime
	.globl _BCD2BIN
	.globl _BIN2BCD
	.globl _RTC_CalcTime
	.globl _RTC_GetUnixTimestamp
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_dayTime::
	.ds 7
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	user/rtc.c: 7: void RTC_Init(void)
;	-----------------------------------------
;	 function RTC_Init
;	-----------------------------------------
_RTC_Init:
	pushw	x
;	user/rtc.c: 9: SoftI2CInit(); 
	call	_SoftI2CInit
;	user/rtc.c: 10: dayTime.sec = 1;
	ldw	x, #_dayTime+0
	ld	a, #0x01
	ld	(x), a
;	user/rtc.c: 11: dayTime.min = 8;
	ldw	x, #_dayTime+0
	ldw	(0x01, sp), x
	ldw	x, (0x01, sp)
	incw	x
	ld	a, #0x08
	ld	(x), a
;	user/rtc.c: 12: dayTime.hour = 11;
	ldw	x, (0x01, sp)
	incw	x
	incw	x
	ld	a, #0x0b
	ld	(x), a
;	user/rtc.c: 13: dayTime.day = 1;
	ldw	x, (0x01, sp)
	ld	a, #0x01
	ld	(0x0003, x), a
;	user/rtc.c: 14: dayTime.date = 16;
	ldw	x, (0x01, sp)
	ld	a, #0x10
	ld	(0x0004, x), a
;	user/rtc.c: 15: dayTime.month = 8;
	ldw	x, (0x01, sp)
	ld	a, #0x08
	ld	(0x0005, x), a
;	user/rtc.c: 16: dayTime.year = 15;
	ldw	x, (0x01, sp)
	ld	a, #0x0f
	ld	(0x0006, x), a
;	user/rtc.c: 17: RTC_SetDateTime(&dayTime);
	ldw	x, (0x01, sp)
	pushw	x
	call	_RTC_SetDateTime
	addw	sp, #4
	ret
;	user/rtc.c: 30: uint8_t DS1307Read(uint8_t address,uint8_t *data)
;	-----------------------------------------
;	 function DS1307Read
;	-----------------------------------------
_DS1307Read:
	push	a
;	user/rtc.c: 33: disableInterrupts();
	sim
;	user/rtc.c: 35: SoftI2CStart();   
	call	_SoftI2CStart
;	user/rtc.c: 37: res=SoftI2CWriteByte(DS1307_SLA_W); //DS1307 address + W   
	push	#0xd0
	call	_SoftI2CWriteByte
	addw	sp, #1
;	user/rtc.c: 39: if(!res)    return FALSE;   
	tnz	a
	jrne	00102$
	clr	a
	jra	00109$
00102$:
;	user/rtc.c: 41: res=SoftI2CWriteByte(address);
	ld	a, (0x04, sp)
	push	a
	call	_SoftI2CWriteByte
	addw	sp, #1
;	user/rtc.c: 43: if(!res)    return FALSE;
	tnz	a
	jrne	00104$
	clr	a
	jra	00109$
00104$:
;	user/rtc.c: 45: SoftI2CStart();
	call	_SoftI2CStart
;	user/rtc.c: 47: res=SoftI2CWriteByte(DS1307_SLA_R); //DS1307 Address + R
	push	#0xd1
	call	_SoftI2CWriteByte
	addw	sp, #1
	ld	(0x01, sp), a
;	user/rtc.c: 49: if(!res)    return FALSE;
	tnz	(0x01, sp)
	jrne	00106$
	clr	a
	jra	00109$
00106$:
;	user/rtc.c: 51: *data=SoftI2CReadByte(0);  
	ldw	x, (0x05, sp)
	pushw	x
	push	#0x00
	call	_SoftI2CReadByte
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 53: if(!res)    return FALSE;   
	tnz	(0x01, sp)
	jrne	00108$
	clr	a
	jra	00109$
00108$:
;	user/rtc.c: 55: SoftI2CStop();
	call	_SoftI2CStop
;	user/rtc.c: 56: enableInterrupts();
	rim
;	user/rtc.c: 57: return TRUE;
	ld	a, #0x01
00109$:
	addw	sp, #1
	ret
;	user/rtc.c: 71: uint8_t DS1307Write(uint8_t address,uint8_t data)
;	-----------------------------------------
;	 function DS1307Write
;	-----------------------------------------
_DS1307Write:
;	user/rtc.c: 74: disableInterrupts();
	sim
;	user/rtc.c: 76: SoftI2CStart();    
	call	_SoftI2CStart
;	user/rtc.c: 78: res=SoftI2CWriteByte(DS1307_SLA_W); //DS1307 address + W    
	push	#0xd0
	call	_SoftI2CWriteByte
	addw	sp, #1
;	user/rtc.c: 80: if(!res)    return FALSE;
	tnz	a
	jrne	00102$
	clr	a
	ret
00102$:
;	user/rtc.c: 82: res=SoftI2CWriteByte(address);
	ld	a, (0x03, sp)
	push	a
	call	_SoftI2CWriteByte
	addw	sp, #1
;	user/rtc.c: 84: if(!res)    return FALSE;
	tnz	a
	jrne	00104$
	clr	a
	ret
00104$:
;	user/rtc.c: 86: res=SoftI2CWriteByte(data);   
	ld	a, (0x04, sp)
	push	a
	call	_SoftI2CWriteByte
	addw	sp, #1
;	user/rtc.c: 88: if(!res)    return FALSE;
	tnz	a
	jrne	00106$
	clr	a
	ret
00106$:
;	user/rtc.c: 90: SoftI2CStop();
	call	_SoftI2CStop
;	user/rtc.c: 91: enableInterrupts();
	rim
;	user/rtc.c: 92: return TRUE;
	ld	a, #0x01
	ret
;	user/rtc.c: 95: void RTC_GetDateTime(RTC_TIME* time) 
;	-----------------------------------------
;	 function RTC_GetDateTime
;	-----------------------------------------
_RTC_GetDateTime:
	sub	sp, #24
;	user/rtc.c: 99: for(i=0;i<8;i++)
	ldw	x, sp
	incw	x
	ldw	(0x17, sp), x
	clr	a
00107$:
;	user/rtc.c: 101: status = DS1307Read(i, &data[i]);
	clrw	x
	ld	xl, a
	addw	x, (0x17, sp)
	push	a
	pushw	x
	push	a
	call	_DS1307Read
	addw	sp, #3
	pop	a
;	user/rtc.c: 99: for(i=0;i<8;i++)
	inc	a
	cp	a, #0x08
	jrc	00107$
;	user/rtc.c: 105: time->sec = BCD2BIN(data[0]&=0x7F);
	ldw	y, (0x1b, sp)
	ldw	(0x15, sp), y
	ldw	x, (0x17, sp)
	ld	a, (x)
	and	a, #0x7f
	ldw	x, (0x17, sp)
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x15, sp)
	ld	(x), a
;	user/rtc.c: 106: time->min = BCD2BIN(data[1]&=0x7F);
	ldw	x, (0x15, sp)
	incw	x
	ldw	(0x13, sp), x
	ldw	x, (0x17, sp)
	incw	x
	ld	a, (x)
	and	a, #0x7f
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x13, sp)
	ld	(x), a
;	user/rtc.c: 107: if((data[2]&0x40)!=0)time->hour=BCD2BIN(data[2]&=0x1F);
	ldw	x, (0x17, sp)
	incw	x
	incw	x
	ld	a, (x)
	ldw	y, (0x15, sp)
	incw	y
	incw	y
	ldw	(0x09, sp), y
	bcp	a, #0x40
	jreq	00105$
	and	a, #0x1f
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x09, sp)
	ld	(x), a
	jra	00106$
00105$:
;	user/rtc.c: 108: else time->hour=BCD2BIN(data[2]&=0x3F);
	and	a, #0x3f
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x09, sp)
	ld	(x), a
00106$:
;	user/rtc.c: 109: time->day = BCD2BIN(data[3]&=0x07);
	ldw	x, (0x15, sp)
	addw	x, #0x0003
	ldw	(0x11, sp), x
	ldw	x, (0x17, sp)
	addw	x, #0x0003
	ld	a, (x)
	and	a, #0x07
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x11, sp)
	ld	(x), a
;	user/rtc.c: 110: time->date = BCD2BIN(data[4]&=0x3F);
	ldw	x, (0x15, sp)
	addw	x, #0x0004
	ldw	(0x0f, sp), x
	ldw	x, (0x17, sp)
	addw	x, #0x0004
	ld	a, (x)
	and	a, #0x3f
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x0f, sp)
	ld	(x), a
;	user/rtc.c: 111: time->month = BCD2BIN(data[5]&=0x1F);
	ldw	x, (0x15, sp)
	addw	x, #0x0005
	ldw	(0x0d, sp), x
	ldw	x, (0x17, sp)
	addw	x, #0x0005
	ld	a, (x)
	and	a, #0x1f
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x0d, sp)
	ld	(x), a
;	user/rtc.c: 112: time->year = BCD2BIN(data[6]&=0xFF);
	ldw	x, (0x15, sp)
	addw	x, #0x0006
	ldw	(0x0b, sp), x
	ldw	x, (0x17, sp)
	addw	x, #0x0006
	ld	a, (x)
	ld	(x), a
	push	a
	call	_BCD2BIN
	addw	sp, #1
	ldw	x, (0x0b, sp)
	ld	(x), a
	addw	sp, #24
	ret
;	user/rtc.c: 115: void RTC_SetDateTime(RTC_TIME* time)
;	-----------------------------------------
;	 function RTC_SetDateTime
;	-----------------------------------------
_RTC_SetDateTime:
	sub	sp, #12
;	user/rtc.c: 119: data[0]=BIN2BCD(time->sec);
	ldw	x, sp
	incw	x
	ldw	(0x0b, sp), x
	ldw	y, (0x0f, sp)
	ldw	(0x09, sp), y
	ldw	x, (0x09, sp)
	ld	a, (x)
	push	a
	call	_BIN2BCD
	addw	sp, #1
	ldw	x, (0x0b, sp)
	ld	(x), a
;	user/rtc.c: 120: data[1]=BIN2BCD(time->min);
	ldw	x, (0x0b, sp)
	incw	x
	ldw	y, (0x09, sp)
	ld	a, (0x1, y)
	pushw	x
	push	a
	call	_BIN2BCD
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 121: data[2]=BIN2BCD(time->hour);
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	y, (0x09, sp)
	ld	a, (0x2, y)
	pushw	x
	push	a
	call	_BIN2BCD
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 122: data[3]=BIN2BCD(time->day);
	ldw	x, (0x0b, sp)
	addw	x, #0x0003
	ldw	y, (0x09, sp)
	ld	a, (0x3, y)
	pushw	x
	push	a
	call	_BIN2BCD
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 123: data[4]=BIN2BCD(time->date);
	ldw	x, (0x0b, sp)
	addw	x, #0x0004
	ldw	y, (0x09, sp)
	ld	a, (0x4, y)
	pushw	x
	push	a
	call	_BIN2BCD
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 124: data[5]=BIN2BCD(time->month);
	ldw	x, (0x0b, sp)
	addw	x, #0x0005
	ldw	y, (0x09, sp)
	ld	a, (0x5, y)
	pushw	x
	push	a
	call	_BIN2BCD
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 125: data[6]=BIN2BCD(time->year);
	ldw	x, (0x0b, sp)
	addw	x, #0x0006
	ldw	y, (0x09, sp)
	ld	a, (0x6, y)
	pushw	x
	push	a
	call	_BIN2BCD
	addw	sp, #1
	popw	x
	ld	(x), a
;	user/rtc.c: 126: data[7]=0;
	ldw	x, (0x0b, sp)
	addw	x, #0x0007
	clr	(x)
;	user/rtc.c: 127: for(i=0;i<8;i++)
	clr	a
00104$:
;	user/rtc.c: 129: status = DS1307Write(i, data[i]);
	clrw	x
	ld	xl, a
	addw	x, (0x0b, sp)
	push	a
	ld	a, (x)
	ld	xl, a
	pop	a
	push	a
	pushw	x
	addw	sp, #1
	push	a
	call	_DS1307Write
	popw	x
	pop	a
;	user/rtc.c: 127: for(i=0;i<8;i++)
	inc	a
	cp	a, #0x08
	jrc	00104$
	addw	sp, #12
	ret
;	user/rtc.c: 135: uint8_t BCD2BIN(uint8_t data)
;	-----------------------------------------
;	 function BCD2BIN
;	-----------------------------------------
_BCD2BIN:
	push	a
;	user/rtc.c: 138: high=(data>>4)&0x0F;
	ld	a, (0x04, sp)
	swap	a
	and	a, #0x0f
	and	a, #0x0f
	ld	xl, a
;	user/rtc.c: 139: low=data&0x0F;
	ld	a, (0x04, sp)
	and	a, #0x0f
	ld	(0x01, sp), a
;	user/rtc.c: 140: return ((high*10)+low);
	ld	a, #0x0a
	mul	x, a
	ld	a, xl
	add	a, (0x01, sp)
	addw	sp, #1
	ret
;	user/rtc.c: 143: uint8_t BIN2BCD(uint8_t data)
;	-----------------------------------------
;	 function BIN2BCD
;	-----------------------------------------
_BIN2BCD:
	push	a
;	user/rtc.c: 146: high=data/10; high =(high<<4)&0xF0;
	clrw	x
	ld	a, (0x04, sp)
	ld	xl, a
	ld	a, #0x0a
	div	x, a
	ld	a, xl
	swap	a
	and	a, #0xf0
	and	a, #0xf0
	ld	(0x01, sp), a
;	user/rtc.c: 147: low=data%10;  low&=0x0F;
	clrw	x
	ld	a, (0x04, sp)
	ld	xl, a
	ld	a, #0x0a
	div	x, a
	and	a, #0x0f
;	user/rtc.c: 148: return ((high)|low);
	or	a, (0x01, sp)
	addw	sp, #1
	ret
;	user/rtc.c: 152: void RTC_CalcTime(DATE_TIME *dt, uint32_t unixTime)
;	-----------------------------------------
;	 function RTC_CalcTime
;	-----------------------------------------
_RTC_CalcTime:
	sub	sp, #8
;	user/rtc.c: 156: epoch = unixTime;
	ldw	y, (0x0f, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x01, sp), y
;	user/rtc.c: 157: gt = localtime(&epoch);			
	ldw	x, sp
	incw	x
	pushw	x
	call	_localtime
	addw	sp, #2
	ldw	(0x05, sp), x
;	user/rtc.c: 158: dt->sec = gt->tm_sec;
	ldw	y, (0x0b, sp)
	ldw	(0x07, sp), y
	ldw	x, (0x07, sp)
	addw	x, #0x0007
	ldw	y, (0x05, sp)
	ld	a, (y)
	ld	(x), a
;	user/rtc.c: 159: dt->min = gt->tm_min;
	ldw	x, (0x07, sp)
	addw	x, #0x0006
	ldw	y, (0x05, sp)
	ld	a, (0x1, y)
	ld	(x), a
;	user/rtc.c: 160: dt->hour = gt->tm_hour;
	ldw	x, (0x07, sp)
	addw	x, #0x0005
	ldw	y, (0x05, sp)
	ld	a, (0x2, y)
	ld	(x), a
;	user/rtc.c: 161: dt->mday = gt->tm_mday;
	ldw	x, (0x07, sp)
	addw	x, #0x0003
	ldw	y, (0x05, sp)
	ld	a, (0x3, y)
	ld	(x), a
;	user/rtc.c: 162: dt->wday = gt->tm_wday + 1;				// tm_wday 0 - 6 (0 = sunday)
	ldw	x, (0x07, sp)
	addw	x, #0x0004
	ldw	y, (0x05, sp)
	ld	a, (0x7, y)
	inc	a
	ld	(x), a
;	user/rtc.c: 163: dt->month = gt->tm_mon + 1;				// tm_mon 0 - 11 (0 = Jan)
	ldw	x, (0x07, sp)
	incw	x
	incw	x
	ldw	y, (0x05, sp)
	ld	a, (0x4, y)
	inc	a
	ld	(x), a
;	user/rtc.c: 164: dt->year = gt->tm_year + 1900;		// tm_year = current year - 1900
	ldw	x, (0x05, sp)
	ldw	x, (0x5, x)
	addw	x, #0x076c
	ldw	y, (0x07, sp)
	ldw	(y), x
	addw	sp, #8
	ret
;	user/rtc.c: 167: uint32_t RTC_GetUnixTimestamp(DATE_TIME *dt)
;	-----------------------------------------
;	 function RTC_GetUnixTimestamp
;	-----------------------------------------
_RTC_GetUnixTimestamp:
	sub	sp, #16
;	user/rtc.c: 171: t.tm_year = dt->year - 1900;
	ldw	x, sp
	incw	x
	ldw	(0x0f, sp), x
	ldw	x, (0x0f, sp)
	addw	x, #0x0005
	ldw	y, (0x13, sp)
	ldw	(0x0d, sp), y
	ldw	y, (0x0d, sp)
	ldw	y, (y)
	subw	y, #0x076c
	ldw	(x), y
;	user/rtc.c: 172: t.tm_mon = dt->month - 1; 				// Month, 0 - jan
	ldw	x, (0x0f, sp)
	addw	x, #0x0004
	ldw	y, (0x0d, sp)
	ld	a, (0x2, y)
	dec	a
	ld	(x), a
;	user/rtc.c: 173: t.tm_mday = dt->mday; 						// Day of the month
	ldw	x, (0x0f, sp)
	addw	x, #0x0003
	ldw	y, (0x0d, sp)
	ld	a, (0x3, y)
	ld	(x), a
;	user/rtc.c: 174: t.tm_hour = dt->hour;
	ldw	x, (0x0f, sp)
	incw	x
	incw	x
	ldw	y, (0x0d, sp)
	ld	a, (0x5, y)
	ld	(x), a
;	user/rtc.c: 175: t.tm_min = dt->min;
	ldw	x, (0x0f, sp)
	incw	x
	ldw	y, (0x0d, sp)
	ld	a, (0x6, y)
	ld	(x), a
;	user/rtc.c: 176: t.tm_sec = dt->sec;
	ldw	x, (0x0d, sp)
	ld	a, (0x7, x)
	ldw	x, (0x0f, sp)
	ld	(x), a
;	user/rtc.c: 177: t.tm_isdst = -1; 									// Is DST on? 1 = yes, 0 = no, -1 = unknown
	ldw	x, (0x0f, sp)
	ld	a, #0xff
	ld	(0x000a, x), a
;	user/rtc.c: 178: t_of_day = mktime(&t);
	ldw	x, (0x0f, sp)
	pushw	x
	call	_mktime
;	user/rtc.c: 179: return (uint32_t)t_of_day; 
	addw	sp, #18
	ret
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
