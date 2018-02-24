# ST Visual Debugger Generated MAKE File, based on i2c_slave_driver.stp

ifeq ($(CFG), )
CFG=Debug
$(warning ***No configuration specified. Defaulting to $(CFG)***)
endif

ToolsetRoot=C:\PROGRA~2\COSMIC\CXSTM8
ToolsetBin=C:\Program Files (x86)\COSMIC\CXSTM8
ToolsetInc=C:\Program Files (x86)\COSMIC\CXSTM8\Hstm8
ToolsetLib=C:\Program Files (x86)\COSMIC\CXSTM8\Lib
ToolsetIncOpts=-i"C:\Program Files (x86)\COSMIC\CXSTM8\Hstm8" 
ToolsetLibOpts=-l"C:\Program Files (x86)\COSMIC\CXSTM8\Lib" 
ObjectExt=o
OutputExt=elf
InputName=$(basename $(notdir $<))


# 
# Debug
# 
ifeq "$(CFG)" "Debug"


OutputPath=Debug
ProjectSFile=i2c_slave_driver
TargetSName=i2c_slave_driver
TargetFName=i2c_slave_driver.elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  +mods0 +debug -pxp -no +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  -xx -l $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) i2c_slave_driver.elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Debug\stm8s_adc1.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_adc1.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_clk.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_clk.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_exti.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_exti.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_gpio.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_gpio.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_i2c.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_i2c.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_itc.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_itc.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_iwdg.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_iwdg.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_tim2.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_tim2.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_tim4.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_tim4.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_uart1.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_uart1.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\i2c_slave_interrupt.$(ObjectExt) : ..\..\src\i2c_slave_interrupt.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\inc\i2c_slave_interrupt.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\main.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\main.$(ObjectExt) : ..\..\src\main.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\main.h ..\..\inc\i2c_slave_interrupt.h ..\..\inc\uart.h c:\PROGRA~2\cosmic\cxstm8\hstm8\string.h c:\PROGRA~2\cosmic\cxstm8\hstm8\stdio.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8s_it.$(ObjectExt) : ..\..\src\stm8s_it.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\inc\stm8s_it.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\uart.$(ObjectExt) : ..\..\src\uart.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h c:\PROGRA~2\cosmic\cxstm8\hstm8\stdlib.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\uart.h ..\..\inc\main.h ..\..\inc\i2c_slave_interrupt.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\uart_printf.$(ObjectExt) : ..\..\src\uart_printf.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h c:\PROGRA~2\cosmic\cxstm8\hstm8\stdio.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8_interrupt_vector.$(ObjectExt) : stm8_interrupt_vector.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\inc\i2c_slave_interrupt.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\main.h ..\..\inc\uart.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  +mods0 +debug -pxp +split -pp -l -dSTM8S003 -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

i2c_slave_driver.elf :  $(OutputPath)\stm8s_adc1.o $(OutputPath)\stm8s_clk.o $(OutputPath)\stm8s_exti.o $(OutputPath)\stm8s_gpio.o $(OutputPath)\stm8s_i2c.o $(OutputPath)\stm8s_itc.o $(OutputPath)\stm8s_iwdg.o $(OutputPath)\stm8s_tim2.o $(OutputPath)\stm8s_tim4.o $(OutputPath)\stm8s_uart1.o $(OutputPath)\i2c_slave_interrupt.o $(OutputPath)\main.o $(OutputPath)\stm8s_it.o $(OutputPath)\uart.o $(OutputPath)\uart_printf.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\i2c_slave_driver.lkf
	$(ToolsetBin)\clnk  -m $(OutputPath)\$(TargetSName).map $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8 

	$(ToolsetBin)\chex  -o $(OutputPath)\$(TargetSName).s19 $(OutputPath)\$(TargetSName).sm8
clean : 
	-@erase $(OutputPath)\stm8s_adc1.o
	-@erase $(OutputPath)\stm8s_clk.o
	-@erase $(OutputPath)\stm8s_exti.o
	-@erase $(OutputPath)\stm8s_gpio.o
	-@erase $(OutputPath)\stm8s_i2c.o
	-@erase $(OutputPath)\stm8s_itc.o
	-@erase $(OutputPath)\stm8s_iwdg.o
	-@erase $(OutputPath)\stm8s_tim2.o
	-@erase $(OutputPath)\stm8s_tim4.o
	-@erase $(OutputPath)\stm8s_uart1.o
	-@erase $(OutputPath)\i2c_slave_interrupt.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\stm8s_it.o
	-@erase $(OutputPath)\uart.o
	-@erase $(OutputPath)\uart_printf.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\i2c_slave_driver.elf
	-@erase $(OutputPath)\i2c_slave_driver.map
	-@erase $(OutputPath)\i2c_slave_driver.st7
	-@erase $(OutputPath)\i2c_slave_driver.s19
	-@erase $(OutputPath)\stm8s_adc1.ls
	-@erase $(OutputPath)\stm8s_clk.ls
	-@erase $(OutputPath)\stm8s_exti.ls
	-@erase $(OutputPath)\stm8s_gpio.ls
	-@erase $(OutputPath)\stm8s_i2c.ls
	-@erase $(OutputPath)\stm8s_itc.ls
	-@erase $(OutputPath)\stm8s_iwdg.ls
	-@erase $(OutputPath)\stm8s_tim2.ls
	-@erase $(OutputPath)\stm8s_tim4.ls
	-@erase $(OutputPath)\stm8s_uart1.ls
	-@erase $(OutputPath)\i2c_slave_interrupt.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\stm8s_it.ls
	-@erase $(OutputPath)\uart.ls
	-@erase $(OutputPath)\uart_printf.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
endif

# 
# Release
# 
ifeq "$(CFG)" "Release"


OutputPath=Release
ProjectSFile=i2c_slave_driver
TargetSName=i2c_slave_driver
TargetFName=i2c_slave_driver.elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  -i..\..\..\libraries\stm8s_stdperiph_driver\inc -i..\..\inc +mods0 -pp $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) i2c_slave_driver.elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Release\stm8s_adc1.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_adc1.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_clk.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_clk.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_exti.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_exti.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_gpio.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_gpio.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_i2c.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_i2c.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_itc.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_itc.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_iwdg.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_iwdg.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_tim2.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_tim2.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_tim4.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_tim4.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_uart1.$(ObjectExt) : ..\..\..\libraries\stm8s_stdperiph_driver\src\stm8s_uart1.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_uart1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\i2c_slave_interrupt.$(ObjectExt) : ..\..\src\i2c_slave_interrupt.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\inc\i2c_slave_interrupt.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\main.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\main.$(ObjectExt) : ..\..\src\main.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\main.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\inc\i2c_slave_interrupt.h ..\..\inc\uart.h c:\PROGRA~2\cosmic\cxstm8\hstm8\string.h c:\PROGRA~2\cosmic\cxstm8\hstm8\stdio.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8s_it.$(ObjectExt) : ..\..\src\stm8s_it.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\inc\stm8s_it.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\uart.$(ObjectExt) : ..\..\src\uart.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h c:\PROGRA~2\cosmic\cxstm8\hstm8\stdlib.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\uart.h ..\..\inc\main.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\inc\i2c_slave_interrupt.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\uart_printf.$(ObjectExt) : ..\..\src\uart_printf.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h c:\PROGRA~2\cosmic\cxstm8\hstm8\stdio.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_interrupt_vector.$(ObjectExt) : stm8_interrupt_vector.c c:\PROGRA~2\cosmic\cxstm8\hstm8\mods0.h ..\..\inc\i2c_slave_interrupt.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s.h ..\..\inc\stm8s_conf.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_awu.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_beep.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_clk.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_exti.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_flash.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_gpio.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_i2c.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_itc.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_iwdg.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_rst.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_spi.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim1.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim2.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_tim4.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_wwdg.h ..\..\inc\main.h ..\..\..\libraries\stm8s_stdperiph_driver\inc\stm8s_adc1.h ..\..\inc\uart.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

i2c_slave_driver.elf :  $(OutputPath)\stm8s_adc1.o $(OutputPath)\stm8s_clk.o $(OutputPath)\stm8s_exti.o $(OutputPath)\stm8s_gpio.o $(OutputPath)\stm8s_i2c.o $(OutputPath)\stm8s_itc.o $(OutputPath)\stm8s_iwdg.o $(OutputPath)\stm8s_tim2.o $(OutputPath)\stm8s_tim4.o $(OutputPath)\stm8s_uart1.o $(OutputPath)\i2c_slave_interrupt.o $(OutputPath)\main.o $(OutputPath)\stm8s_it.o $(OutputPath)\uart.o $(OutputPath)\uart_printf.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\i2c_slave_driver.lkf
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8 

	$(ToolsetBin)\chex  -o $(OutputPath)\$(TargetSName).s19 $(OutputPath)\$(TargetSName).sm8
clean : 
	-@erase $(OutputPath)\stm8s_adc1.o
	-@erase $(OutputPath)\stm8s_clk.o
	-@erase $(OutputPath)\stm8s_exti.o
	-@erase $(OutputPath)\stm8s_gpio.o
	-@erase $(OutputPath)\stm8s_i2c.o
	-@erase $(OutputPath)\stm8s_itc.o
	-@erase $(OutputPath)\stm8s_iwdg.o
	-@erase $(OutputPath)\stm8s_tim2.o
	-@erase $(OutputPath)\stm8s_tim4.o
	-@erase $(OutputPath)\stm8s_uart1.o
	-@erase $(OutputPath)\i2c_slave_interrupt.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\stm8s_it.o
	-@erase $(OutputPath)\uart.o
	-@erase $(OutputPath)\uart_printf.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\i2c_slave_driver.elf
	-@erase $(OutputPath)\i2c_slave_driver.map
	-@erase $(OutputPath)\i2c_slave_driver.st7
	-@erase $(OutputPath)\i2c_slave_driver.s19
	-@erase $(OutputPath)\stm8s_adc1.ls
	-@erase $(OutputPath)\stm8s_clk.ls
	-@erase $(OutputPath)\stm8s_exti.ls
	-@erase $(OutputPath)\stm8s_gpio.ls
	-@erase $(OutputPath)\stm8s_i2c.ls
	-@erase $(OutputPath)\stm8s_itc.ls
	-@erase $(OutputPath)\stm8s_iwdg.ls
	-@erase $(OutputPath)\stm8s_tim2.ls
	-@erase $(OutputPath)\stm8s_tim4.ls
	-@erase $(OutputPath)\stm8s_uart1.ls
	-@erase $(OutputPath)\i2c_slave_interrupt.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\stm8s_it.ls
	-@erase $(OutputPath)\uart.ls
	-@erase $(OutputPath)\uart_printf.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
endif
