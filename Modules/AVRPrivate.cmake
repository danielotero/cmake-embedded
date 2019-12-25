#
# Return the "avr-gcc" macro definition for a given MCU
#
function(_avr_get_definition_for_mcu mcu_name out_var)
    string(TOUPPER "${mcu_name}" mcu_name)
    string(REPLACE "XMEGA" "xmega" mcu_name ${mcu_name})
    string(REPLACE "MEGA" "mega"  mcu_name ${mcu_name})
    string(REPLACE "TINY" "tiny"  mcu_name ${mcu_name})

    set(${out_var} "__AVR_${mcu_name}__" PARENT_SCOPE)
endfunction()

#
# Return the architecture for the given MCU or empty if the MCU is not recognized
#
function(_avr_get_arch_for_mcu mcu_name out_var)
    # This is a "map" from each MCU to its architecture. The main source was:
    # https://www.microchip.com/webdoc/AVRLibcReferenceManual/using_tools_1using_avr_gcc_mach_opt.html
    # Some minor adjustments were done to match the GCC naming.
    set(MCU_at90s1200_ARCH "avr1")
    set(MCU_attiny11_ARCH "avr1")
    set(MCU_attiny12_ARCH "avr1")
    set(MCU_attiny15_ARCH "avr1")
    set(MCU_attiny28_ARCH "avr1")
    set(MCU_at90s2313_ARCH "avr2")
    set(MCU_at90s2323_ARCH "avr2")
    set(MCU_at90s2333_ARCH "avr2")
    set(MCU_at90s2343_ARCH "avr2")
    set(MCU_attiny22_ARCH "avr2")
    set(MCU_attiny26_ARCH "avr2")
    set(MCU_at90s4414_ARCH "avr2")
    set(MCU_at90s4433_ARCH "avr2")
    set(MCU_at90s4434_ARCH "avr2")
    set(MCU_at90s8515_ARCH "avr2")
    set(MCU_at90c8534_ARCH "avr2")
    set(MCU_at90s8535_ARCH "avr2")
    set(MCU_at86rf401_ARCH "avr25")
    set(MCU_ata6289_ARCH "avr25")
    set(MCU_ata5272_ARCH "avr25")
    set(MCU_ata6616c_ARCH "avr25")
    set(MCU_attiny13_ARCH "avr25")
    set(MCU_attiny13a_ARCH "avr25")
    set(MCU_attiny2313_ARCH "avr25")
    set(MCU_attiny2313a_ARCH "avr25")
    set(MCU_attiny24_ARCH "avr25")
    set(MCU_attiny24a_ARCH "avr25")
    set(MCU_attiny25_ARCH "avr25")
    set(MCU_attiny261_ARCH "avr25")
    set(MCU_attiny261a_ARCH "avr25")
    set(MCU_attiny4313_ARCH "avr25")
    set(MCU_attiny43u_ARCH "avr25")
    set(MCU_attiny44_ARCH "avr25")
    set(MCU_attiny44a_ARCH "avr25")
    set(MCU_attiny441_ARCH "avr25")
    set(MCU_attiny45_ARCH "avr25")
    set(MCU_attiny461_ARCH "avr25")
    set(MCU_attiny461a_ARCH "avr25")
    set(MCU_attiny48_ARCH "avr25")
    set(MCU_attiny828_ARCH "avr25")
    set(MCU_attiny84_ARCH "avr25")
    set(MCU_attiny84a_ARCH "avr25")
    set(MCU_attiny841_ARCH "avr25")
    set(MCU_attiny85_ARCH "avr25")
    set(MCU_attiny861_ARCH "avr25")
    set(MCU_attiny861a_ARCH "avr25")
    set(MCU_attiny87_ARCH "avr25")
    set(MCU_attiny88_ARCH "avr25")
    set(MCU_atmega603_ARCH "avr3")
    set(MCU_at43usb355_ARCH "avr3")
    set(MCU_atmega103_ARCH "avr31")
    set(MCU_at43usb320_ARCH "avr31")
    set(MCU_at90usb82_ARCH "avr35")
    set(MCU_at90usb162_ARCH "avr35")
    set(MCU_ata5505_ARCH "avr35")
    set(MCU_ata6617c_ARCH "avr35")
    set(MCU_ata664251_ARCH "avr35")
    set(MCU_atmega8u2_ARCH "avr35")
    set(MCU_atmega16u2_ARCH "avr35")
    set(MCU_atmega32u2_ARCH "avr35")
    set(MCU_attiny167_ARCH "avr35")
    set(MCU_attiny1634_ARCH "avr35")
    set(MCU_at76c711_ARCH "avr3")
    set(MCU_ata6285_ARCH "avr4")
    set(MCU_ata6286_ARCH "avr4")
    set(MCU_ata6612c_ARCH "avr4")
    set(MCU_atmega48_ARCH "avr4")
    set(MCU_atmega48a_ARCH "avr4")
    set(MCU_atmega48pa_ARCH "avr4")
    set(MCU_atmega48p_ARCH "avr4")
    set(MCU_atmega8_ARCH "avr4")
    set(MCU_atmega8a_ARCH "avr4")
    set(MCU_atmega8515_ARCH "avr4")
    set(MCU_atmega8535_ARCH "avr4")
    set(MCU_atmega88_ARCH "avr4")
    set(MCU_atmega88a_ARCH "avr4")
    set(MCU_atmega88p_ARCH "avr4")
    set(MCU_atmega88pa_ARCH "avr4")
    set(MCU_atmega8hva_ARCH "avr4")
    set(MCU_at90pwm1_ARCH "avr4")
    set(MCU_at90pwm2_ARCH "avr4")
    set(MCU_at90pwm2b_ARCH "avr4")
    set(MCU_at90pwm3_ARCH "avr4")
    set(MCU_at90pwm3b_ARCH "avr4")
    set(MCU_at90pwm81_ARCH "avr4")
    set(MCU_at90can32_ARCH "avr5")
    set(MCU_at90can64_ARCH "avr5")
    set(MCU_at90pwm161_ARCH "avr5")
    set(MCU_at90pwm216_ARCH "avr5")
    set(MCU_at90pwm316_ARCH "avr5")
    set(MCU_at90scr100_ARCH "avr5")
    set(MCU_at90usb646_ARCH "avr5")
    set(MCU_at90usb647_ARCH "avr5")
    set(MCU_at94k_ARCH "avr5")
    set(MCU_atmega16_ARCH "avr5")
    set(MCU_ata5790_ARCH "avr5")
    set(MCU_ata5702m322_ARCH "avr5")
    set(MCU_ata5782_ARCH "avr5")
    set(MCU_ata6613c_ARCH "avr5")
    set(MCU_ata6614q_ARCH "avr5")
    set(MCU_ata5790n_ARCH "avr5")
    set(MCU_ata5795_ARCH "avr5")
    set(MCU_ata5831_ARCH "avr5")
    set(MCU_atmega161_ARCH "avr5")
    set(MCU_atmega162_ARCH "avr5")
    set(MCU_atmega163_ARCH "avr5")
    set(MCU_atmega164a_ARCH "avr5")
    set(MCU_atmega164p_ARCH "avr5")
    set(MCU_atmega164pa_ARCH "avr5")
    set(MCU_atmega165_ARCH "avr5")
    set(MCU_atmega165a_ARCH "avr5")
    set(MCU_atmega165p_ARCH "avr5")
    set(MCU_atmega165pa_ARCH "avr5")
    set(MCU_atmega168_ARCH "avr5")
    set(MCU_atmega168a_ARCH "avr5")
    set(MCU_atmega168p_ARCH "avr5")
    set(MCU_atmega168pa_ARCH "avr5")
    set(MCU_atmega169_ARCH "avr5")
    set(MCU_atmega169a_ARCH "avr5")
    set(MCU_atmega169p_ARCH "avr5")
    set(MCU_atmega169pa_ARCH "avr5")
    set(MCU_atmega16a_ARCH "avr5")
    set(MCU_atmega16hva_ARCH "avr5")
    set(MCU_atmega16hva2_ARCH "avr5")
    set(MCU_atmega16hvb_ARCH "avr5")
    set(MCU_atmega16hvbrevb_ARCH "avr5")
    set(MCU_atmega16m1_ARCH "avr5")
    set(MCU_atmega16u4_ARCH "avr5")
    set(MCU_atmega32_ARCH "avr5")
    set(MCU_atmega32a_ARCH "avr5")
    set(MCU_atmega323_ARCH "avr5")
    set(MCU_atmega324a_ARCH "avr5")
    set(MCU_atmega324p_ARCH "avr5")
    set(MCU_atmega324pa_ARCH "avr5")
    set(MCU_atmega325_ARCH "avr5")
    set(MCU_atmega325a_ARCH "avr5")
    set(MCU_atmega325p_ARCH "avr5")
    set(MCU_atmega325pa_ARCH "avr5")
    set(MCU_atmega3250_ARCH "avr5")
    set(MCU_atmega3250a_ARCH "avr5")
    set(MCU_atmega3250p_ARCH "avr5")
    set(MCU_atmega3250pa_ARCH "avr5")
    set(MCU_atmega328_ARCH "avr5")
    set(MCU_atmega328p_ARCH "avr5")
    set(MCU_atmega329_ARCH "avr5")
    set(MCU_atmega329a_ARCH "avr5")
    set(MCU_atmega329p_ARCH "avr5")
    set(MCU_atmega329pa_ARCH "avr5")
    set(MCU_atmega3290_ARCH "avr5")
    set(MCU_atmega3290a_ARCH "avr5")
    set(MCU_atmega3290p_ARCH "avr5")
    set(MCU_atmega3290pa_ARCH "avr5")
    set(MCU_atmega32c1_ARCH "avr5")
    set(MCU_atmega32hvb_ARCH "avr5")
    set(MCU_atmega32hvbrevb_ARCH "avr5")
    set(MCU_atmega32m1_ARCH "avr5")
    set(MCU_atmega32u4_ARCH "avr5")
    set(MCU_atmega32u6_ARCH "avr5")
    set(MCU_atmega406_ARCH "avr5")
    set(MCU_atmega64rfr2_ARCH "avr5")
    set(MCU_atmega644rfr2_ARCH "avr5")
    set(MCU_atmega64_ARCH "avr5")
    set(MCU_atmega64a_ARCH "avr5")
    set(MCU_atmega640_ARCH "avr5")
    set(MCU_atmega644_ARCH "avr5")
    set(MCU_atmega644a_ARCH "avr5")
    set(MCU_atmega644p_ARCH "avr5")
    set(MCU_atmega644pa_ARCH "avr5")
    set(MCU_atmega645_ARCH "avr5")
    set(MCU_atmega645a_ARCH "avr5")
    set(MCU_atmega645p_ARCH "avr5")
    set(MCU_atmega6450_ARCH "avr5")
    set(MCU_atmega6450a_ARCH "avr5")
    set(MCU_atmega6450p_ARCH "avr5")
    set(MCU_atmega649_ARCH "avr5")
    set(MCU_atmega649a_ARCH "avr5")
    set(MCU_atmega6490_ARCH "avr5")
    set(MCU_atmega6490a_ARCH "avr5")
    set(MCU_atmega6490p_ARCH "avr5")
    set(MCU_atmega649p_ARCH "avr5")
    set(MCU_atmega64c1_ARCH "avr5")
    set(MCU_atmega64hve_ARCH "avr5")
    set(MCU_atmega64hve2_ARCH "avr5")
    set(MCU_atmega64m1_ARCH "avr5")
    set(MCU_m3000_ARCH "avr5")
    set(MCU_at90can128_ARCH "avr51")
    set(MCU_at90usb1286_ARCH "avr51")
    set(MCU_at90usb1287_ARCH "avr51")
    set(MCU_atmega128_ARCH "avr51")
    set(MCU_atmega128a_ARCH "avr51")
    set(MCU_atmega1280_ARCH "avr51")
    set(MCU_atmega1281_ARCH "avr51")
    set(MCU_atmega1284_ARCH "avr51")
    set(MCU_atmega1284p_ARCH "avr51")
    set(MCU_atmega128rfr2_ARCH "avr51")
    set(MCU_atmega1284rfr2_ARCH "avr51")
    set(MCU_atmega2560_ARCH "avr6")
    set(MCU_atmega2561_ARCH "avr6")
    set(MCU_atmega256rfr2_ARCH "avr6")
    set(MCU_atmega2564rfr2_ARCH "avr6")
    set(MCU_atxmega16a4_ARCH "avrxmega2")
    set(MCU_atxmega16a4u_ARCH "avrxmega2")
    set(MCU_atxmega16c4_ARCH "avrxmega2")
    set(MCU_atxmega16d4_ARCH "avrxmega2")
    set(MCU_atxmega32a4_ARCH "avrxmega2")
    set(MCU_atxmega32a4u_ARCH "avrxmega2")
    set(MCU_atxmega32c3_ARCH "avrxmega2")
    set(MCU_atxmega32c4_ARCH "avrxmega2")
    set(MCU_atxmega32d3_ARCH "avrxmega2")
    set(MCU_atxmega32d4_ARCH "avrxmega2")
    set(MCU_atxmega8e5_ARCH "avrxmega2")
    set(MCU_atxmega16e5_ARCH "avrxmega2")
    set(MCU_atxmega32e5_ARCH "avrxmega2")
    set(MCU_atxmega64a3_ARCH "avrxmega4")
    set(MCU_atxmega64a3u_ARCH "avrxmega4")
    set(MCU_atxmega64a4u_ARCH "avrxmega4")
    set(MCU_atxmega64b1_ARCH "avrxmega4")
    set(MCU_atxmega64b3_ARCH "avrxmega4")
    set(MCU_atxmega64c3_ARCH "avrxmega4")
    set(MCU_atxmega64d3_ARCH "avrxmega4")
    set(MCU_atxmega64d4_ARCH "avrxmega4")
    set(MCU_atxmega64a1_ARCH "avrxmega5")
    set(MCU_atxmega64a1u_ARCH "avrxmega5")
    set(MCU_atxmega128a3_ARCH "avrxmega6")
    set(MCU_atxmega128a3u_ARCH "avrxmega6")
    set(MCU_atxmega128b1_ARCH "avrxmega6")
    set(MCU_atxmega128b3_ARCH "avrxmega6")
    set(MCU_atxmega128c3_ARCH "avrxmega6")
    set(MCU_atxmega128d3_ARCH "avrxmega6")
    set(MCU_atxmega128d4_ARCH "avrxmega6")
    set(MCU_atxmega192a3_ARCH "avrxmega6")
    set(MCU_atxmega192a3u_ARCH "avrxmega6")
    set(MCU_atxmega192c3_ARCH "avrxmega6")
    set(MCU_atxmega192d3_ARCH "avrxmega6")
    set(MCU_atxmega256a3_ARCH "avrxmega6")
    set(MCU_atxmega256a3u_ARCH "avrxmega6")
    set(MCU_atxmega256a3b_ARCH "avrxmega6")
    set(MCU_atxmega256a3bu_ARCH "avrxmega6")
    set(MCU_atxmega256c3_ARCH "avrxmega6")
    set(MCU_atxmega256d3_ARCH "avrxmega6")
    set(MCU_atxmega384c3_ARCH "avrxmega6")
    set(MCU_atxmega384d3_ARCH "avrxmega6")
    set(MCU_atxmega128a1_ARCH "avrxmega7")
    set(MCU_atxmega128a1u_ARCH "avrxmega7")
    set(MCU_atxmega128a4u_ARCH "avrxmega7")
    set(MCU_attiny4_ARCH "avrtiny")
    set(MCU_attiny5_ARCH "avrtiny")
    set(MCU_attiny9_ARCH "avrtiny")
    set(MCU_attiny10_ARCH "avrtiny")
    set(MCU_attiny20_ARCH "avrtiny")
    set(MCU_attiny40_ARCH "avrtiny")

    string(TOLOWER "${mcu_name}" mcu_name)
    if (DEFINED MCU_${mcu_name}_ARCH)
        set(${out_var} "${MCU_${mcu_name}_ARCH}" PARENT_SCOPE)
    else()
        set(${out_var} "" PARENT_SCOPE)
    endif()
endfunction()

#
# Return the set of "avr-gcc" default macro definitions for a given MCU
#
function(_avr_get_gcc_default_definitions mcu_name out_var)
    # These are the definitions that 'avr-gcc' (version 9.2.0) presets for each
    # architecture. You can get those with:
    # `avr-gcc -mmcu=<arch> -dM -E - < /dev/null | grep __AVR`
    set(ARCH_avr1_DEFINES "__AVR_ARCH__=1"
                          "__AVR_ASM_ONLY__=1"
                          "__AVR_HAVE_16BIT_SP__=1"
                          "__AVR_HAVE_SPH__=1"
                          "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr2_DEFINES "__AVR_ARCH__=2"
                          "__AVR_ERRATA_SKIP__=1"
                          "__AVR_HAVE_16BIT_SP__=1"
                          "__AVR_HAVE_SPH__=1"
                          "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr25_DEFINES "__AVR_ARCH__=25"
                           "__AVR_HAVE_16BIT_SP__=1"
                           "__AVR_HAVE_LPMX__=1"
                           "__AVR_HAVE_MOVW__=1"
                           "__AVR_HAVE_SPH__=1"
                           "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr3_DEFINES "__AVR_ARCH__=3"
                          "__AVR_HAVE_16BIT_SP__=1"
                          "__AVR_HAVE_JMP_CALL__=1"
                          "__AVR_HAVE_SPH__=1"
                          "__AVR_MEGA__=1"
                          "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr31_DEFINES "__AVR_ARCH__=31"
                           "__AVR_ERRATA_SKIP__=1"
                           "__AVR_ERRATA_SKIP_JMP_CALL__=1"
                           "__AVR_HAVE_16BIT_SP__=1"
                           "__AVR_HAVE_ELPM__=1"
                           "__AVR_HAVE_JMP_CALL__=1"
                           "__AVR_HAVE_RAMPZ__=1"
                           "__AVR_HAVE_SPH__=1"
                           "__AVR_MEGA__=1"
                           "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr35_DEFINES "__AVR_ARCH__=35"
                           "__AVR_HAVE_16BIT_SP__=1"
                           "__AVR_HAVE_JMP_CALL__=1"
                           "__AVR_HAVE_LPMX__=1"
                           "__AVR_HAVE_MOVW__=1"
                           "__AVR_HAVE_SPH__=1"
                           "__AVR_MEGA__=1"
                           "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr4_DEFINES "__AVR_ARCH__=4"
                          "__AVR_ENHANCED__=1"
                          "__AVR_HAVE_16BIT_SP__=1"
                          "__AVR_HAVE_LPMX__=1"
                          "__AVR_HAVE_MOVW__=1"
                          "__AVR_HAVE_MUL__=1"
                          "__AVR_HAVE_SPH__=1"
                          "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr5_DEFINES "__AVR_ARCH__=5"
                          "__AVR_ENHANCED__=1"
                          "__AVR_HAVE_16BIT_SP__=1"
                          "__AVR_HAVE_JMP_CALL__=1"
                          "__AVR_HAVE_LPMX__=1"
                          "__AVR_HAVE_MOVW__=1"
                          "__AVR_HAVE_MUL__=1"
                          "__AVR_HAVE_SPH__=1"
                          "__AVR_MEGA__=1"
                          "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr51_DEFINES "__AVR_ARCH__=51"
                           "__AVR_ENHANCED__=1"
                           "__AVR_HAVE_16BIT_SP__=1"
                           "__AVR_HAVE_ELPM__=1"
                           "__AVR_HAVE_ELPMX__=1"
                           "__AVR_HAVE_JMP_CALL__=1"
                           "__AVR_HAVE_LPMX__=1"
                           "__AVR_HAVE_MOVW__=1"
                           "__AVR_HAVE_MUL__=1"
                           "__AVR_HAVE_RAMPZ__=1"
                           "__AVR_HAVE_SPH__=1"
                           "__AVR_MEGA__=1"
                           "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avr6_DEFINES "__AVR_ARCH__=6"
                          "__AVR_ENHANCED__=1"
                          "__AVR_HAVE_16BIT_SP__=1"
                          "__AVR_HAVE_EIJMP_EICALL__=1"
                          "__AVR_HAVE_ELPM__=1"
                          "__AVR_HAVE_ELPMX__=1"
                          "__AVR_HAVE_JMP_CALL__=1"
                          "__AVR_HAVE_LPMX__=1"
                          "__AVR_HAVE_MOVW__=1"
                          "__AVR_HAVE_MUL__=1"
                          "__AVR_HAVE_RAMPZ__=1"
                          "__AVR_HAVE_SPH__=1"
                          "__AVR_MEGA__=1"
                          "__AVR_SFR_OFFSET__=0x20"
    )
    set(ARCH_avrxmega2_DEFINES "__AVR_ARCH__=102"
                               "__AVR_ENHANCED__=1"
                               "__AVR_HAVE_16BIT_SP__=1"
                               "__AVR_HAVE_JMP_CALL__=1"
                               "__AVR_HAVE_LPMX__=1"
                               "__AVR_HAVE_MOVW__=1"
                               "__AVR_HAVE_MUL__=1"
                               "__AVR_HAVE_SPH__=1"
                               "__AVR_MEGA__=1"
                               "__AVR_SFR_OFFSET__=0x0"
                               "__AVR_XMEGA__=1"
    )
    set(ARCH_avrxmega3_DEFINES "__AVR_ARCH__=103"
                               "__AVR_ENHANCED__=1"
                               "__AVR_HAVE_16BIT_SP__=1"
                               "__AVR_HAVE_JMP_CALL__=1"
                               "__AVR_HAVE_LPMX__=1"
                               "__AVR_HAVE_MOVW__=1"
                               "__AVR_HAVE_MUL__=1"
                               "__AVR_HAVE_SPH__=1"
                               "__AVR_MEGA__=1"
                               "__AVR_PM_BASE_ADDRESS__=0x8000"
                               "__AVR_SFR_OFFSET__=0x0"
                               "__AVR_XMEGA__=1"
    )
    set(ARCH_avrxmega4_DEFINES "__AVR_ARCH__=104"
                               "__AVR_ENHANCED__=1"
                               "__AVR_HAVE_16BIT_SP__=1"
                               "__AVR_HAVE_ELPM__=1"
                               "__AVR_HAVE_ELPMX__=1"
                               "__AVR_HAVE_JMP_CALL__=1"
                               "__AVR_HAVE_LPMX__=1"
                               "__AVR_HAVE_MOVW__=1"
                               "__AVR_HAVE_MUL__=1"
                               "__AVR_HAVE_RAMPZ__=1"
                               "__AVR_HAVE_SPH__=1"
                               "__AVR_MEGA__=1"
                               "__AVR_SFR_OFFSET__=0x0"
                               "__AVR_XMEGA__=1"
    )
    set(ARCH_avrxmega5_DEFINES "__AVR_ARCH__=105"
                               "__AVR_ENHANCED__=1"
                               "__AVR_HAVE_16BIT_SP__=1"
                               "__AVR_HAVE_ELPM__=1"
                               "__AVR_HAVE_ELPMX__=1"
                               "__AVR_HAVE_JMP_CALL__=1"
                               "__AVR_HAVE_LPMX__=1"
                               "__AVR_HAVE_MOVW__=1"
                               "__AVR_HAVE_MUL__=1"
                               "__AVR_HAVE_RAMPD__=1"
                               "__AVR_HAVE_RAMPX__=1"
                               "__AVR_HAVE_RAMPY__=1"
                               "__AVR_HAVE_RAMPZ__=1"
                               "__AVR_HAVE_SPH__=1"
                               "__AVR_MEGA__=1"
                               "__AVR_SFR_OFFSET__=0x0"
                               "__AVR_XMEGA__=1"
    )
    set(ARCH_avrxmega6_DEFINES "__AVR_ARCH__=106"
                               "__AVR_ENHANCED__=1"
                               "__AVR_HAVE_16BIT_SP__=1"
                               "__AVR_HAVE_EIJMP_EICALL__=1"
                               "__AVR_HAVE_ELPM__=1"
                               "__AVR_HAVE_ELPMX__=1"
                               "__AVR_HAVE_JMP_CALL__=1"
                               "__AVR_HAVE_LPMX__=1"
                               "__AVR_HAVE_MOVW__=1"
                               "__AVR_HAVE_MUL__=1"
                               "__AVR_HAVE_RAMPZ__=1"
                               "__AVR_HAVE_SPH__=1"
                               "__AVR_MEGA__=1"
                               "__AVR_SFR_OFFSET__=0x0"
                               "__AVR_XMEGA__=1"
    )
    set(ARCH_avrxmega7_DEFINES "__AVR_ARCH__=107"
                               "__AVR_ENHANCED__=1"
                               "__AVR_HAVE_16BIT_SP__=1"
                               "__AVR_HAVE_EIJMP_EICALL__=1"
                               "__AVR_HAVE_ELPM__=1"
                               "__AVR_HAVE_ELPMX__=1"
                               "__AVR_HAVE_JMP_CALL__=1"
                               "__AVR_HAVE_LPMX__=1"
                               "__AVR_HAVE_MOVW__=1"
                               "__AVR_HAVE_MUL__=1"
                               "__AVR_HAVE_RAMPD__=1"
                               "__AVR_HAVE_RAMPX__=1"
                               "__AVR_HAVE_RAMPY__=1"
                               "__AVR_HAVE_RAMPZ__=1"
                               "__AVR_HAVE_SPH__=1"
                               "__AVR_MEGA__=1"
                               "__AVR_SFR_OFFSET__=0x0"
                               "__AVR_XMEGA__=1"
    )
    set(ARCH_avrtiny_DEFINES "__AVR_ARCH__=100"
                             "__AVR_HAVE_16BIT_SP__=1"
                             "__AVR_HAVE_SPH__=1"
                             "__AVR_PM_BASE_ADDRESS__=0x4000"
                             "__AVR_SFR_OFFSET__=0x0"
                             "__AVR_TINY__=1"
                             "__AVR_TINY_PM_BASE_ADDRESS__=0x4000"
    )

    # Clear our result variable
    set(definitions)

    string(TOLOWER "${mcu_name}" mcu_name)

    if (DEFINED ARCH_${mcu_name}_DEFINES)
        # No actual MCU provided, but the architecture
        list(APPEND definitions "${ARCH_${mcu_name}_DEFINES}")
        # Add the common platform definitions
        list(APPEND definitions "__AVR=1" "__AVR__=1")
    else()
        _avr_get_arch_for_mcu("${mcu_name}" mcu_arch)
        if (DEFINED ARCH_${mcu_arch}_DEFINES)
            # Recognized MCU, set their custom definitions
            _avr_get_definition_for_mcu(${mcu_name} mcu_definition)
            list(APPEND definitions "${mcu_definition}"
                                    "__AVR_DEVICE_NAME__=${mcu_name}"
                                    "${ARCH_${mcu_arch}_DEFINES}"
            )
            # Add the common platform definitions
            list(APPEND definitions "__AVR=1" "__AVR__=1")
        endif()
    endif()

    set(${out_var} ${definitions} PARENT_SCOPE)
endfunction()

#
# Recover the MCU the given target was compiled for
#
function(_avr_get_target_mcu target result)
    get_target_property(mcu ${target} "CMAKEMBED_AVR_MCU")
    if (mcu)
        set("${result}" ${mcu} PARENT_SCOPE)
        return()
    endif()

    get_property(mcu GLOBAL PROPERTY "CMAKEMBED_AVR_MCU")
    if (mcu)
        set("${result}" ${mcu} PARENT_SCOPE)
        return()
    endif()
endfunction()

#
# Add new outputs to extract the code and the eeprom segments from the target
# executable. Additionally, the function accepts a PRINT_SIZE flag to print the
# binary size after each compilation.
#
function(_avr_build_firmware target)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        "PRINT_SIZE"      # Options
        ""                # Single-value options
        ""                # Multi-value options
        ${ARGN}
    )

    set(code_file "${target}.hex")
    set(eeprom_file "${target}.eeprom.hex")

    _avr_get_target_mcu(${target} mcu)
    if (${ARG_PRINT_SIZE} AND CMAKEMBED_AVR_SIZE AND mcu)
        # Print the size for the given MCU after the executable is built
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND "${CMAKEMBED_AVR_SIZE}"
                --format=avr
                --mcu=${mcu}
                ${target}
            COMMENT "Computing the size of '${target}' for '${mcu}'"
        )
    endif()

    # Extract the EEPROM data from the executable
    add_custom_command(OUTPUT ${code_file}
        COMMAND "${CMAKEMBED_AVR_OBJCOPY}"
            --only-section=.text
            --only-section=.data
            --output-target=ihex
            ${target}
            ${code_file}
        DEPENDS ${target}
        COMMENT "Extracting .text and .data segments of '${target}'"
    )
    # Store the code file as a target property
    set_property(TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_CODE_FILE" "${code_file}"
    )

    # Extract the EEPROM data from the executable
    add_custom_command(OUTPUT ${eeprom_file}
        COMMAND "${CMAKEMBED_AVR_OBJCOPY}"
            --only-section=.eeprom
            --set-section-flags=.eeprom=alloc,load
            --change-section-lma .eeprom=0
            --no-change-warnings
            --output-target=ihex
            ${target}
            ${eeprom_file}
        DEPENDS ${target}
        COMMENT "Extracting .eeprom segment of '${target}'"
    )
    # Store the eeprom file as a target property
    set_property(TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_EEPROM_FILE" "${eeprom_file}"
    )
endfunction()

#
# Add a new custom target to upload (with avrdude) the given executable with
# the given options (PROGRAMMER, BAUDRATE, PORT and OTHER_ARGS). Also, an
# EEPROM_TARGET option can be suplied to create another custom target to upload
# the target EEPROM data.
#
function(_avr_add_upload_target target_name target)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        ""                                         # Options
        "PROGRAMMER;BAUDRATE;PORT;EEPROM_TARGET"   # Single-value options
        "OTHER_ARGS"                               # Multi-value options
        ${ARGN}
    )

    # It only makes sense to continue if we have the upload tool
    if (NOT CMAKEMBED_AVR_AVRDUDE)
        message(WARNING
            "Not upload targets for '${target}' were generated as no avrdude "
            "was found."
        )
        return()
    endif()

    _avr_get_target_mcu(${target} mcu ${AVR_PRINT_SIZE})
    if (NOT mcu)
        message(FATAL_ERROR "Can not find the target MCU for '${target}'")
    endif()

    # Recover the code file for the given target
    get_property(code_file
        TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_CODE_FILE"
    )
    if (NOT code_file)
       message(FATAL_ERROR "Can not find the code segment for '${target}'")
    endif()

    # Build the avrdude set of arguments from the function inputs
    set(AVRDUDE_ARGS -p ${mcu})
    if (ARG_PROGRAMMER)
        list(APPEND AVRDUDE_ARGS -c ${ARG_PROGRAMMER})
    endif()
    if (ARG_PORT)
        list(APPEND AVRDUDE_ARGS -P ${ARG_PORT})
    endif()
    if (ARG_BAUDRATE)
        list(APPEND AVRDUDE_ARGS -b ${ARG_BAUDRATE})
    endif()
    if (ARG_OTHER_ARGS)
        list(APPEND AVRDUDE_ARGS ${ARG_OTHER_ARGS})
    endif()

    # This is the command to upload the code to the MCU
    add_custom_target(${target_name}
        ${CMAKEMBED_AVR_AVRDUDE}
            -U flash:w:"${code_file}":i
            ${AVRDUDE_ARGS}
        DEPENDS ${code_file}
        COMMENT "Uploading '${code_file}' to '${mcu}' flash memory"
        USES_TERMINAL
    )

    # Also try to recovert the EEPROM file
    get_property(eeprom_file
        TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_EEPROM_FILE"
    )

    if (eeprom_file AND ARG_EEPROM_TARGET)
        # This is the command to upload the EEPROM data to the MCU
        add_custom_target(${ARG_EEPROM_TARGET}
            ${CMAKEMBED_AVR_AVRDUDE}
                -U eeprom:w:"${eeprom_file}"
                ${AVRDUDE_ARGS}
            DEPENDS ${eeprom_file}
            COMMENT "Uploading '${eeprom_file}' to '${mcu}' EEPROM"
            USES_TERMINAL
        )
    endif()
endfunction()