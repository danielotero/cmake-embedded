###############################################################################
#            Private functions related to preprocessor definitions            #
###############################################################################
# Return the "avr-gcc" macro definition for a given MCU
function(_avr_get_definition_for_mcu mcu_name out_var)
    string(TOUPPER "${mcu_name}" mcu_name)
    string(REPLACE "XMEGA" "xmega" mcu_name ${mcu_name})
    string(REPLACE "MEGA" "mega"  mcu_name ${mcu_name})
    string(REPLACE "TINY" "tiny"  mcu_name ${mcu_name})

    set(${out_var} "__AVR_${mcu_name}__" PARENT_SCOPE)
endfunction()

# Return the architecture for the given MCU or empty if the MCU is not recognized
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

# Return the set of "avr-gcc" default macro definitions for a given MCU
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

###############################################################################
#                              Public functions                               #
###############################################################################
# Configure the CMake target to compile for the given AVR MCU
function(avr_set_target_compile_options target mcu_name)
    _avr_get_arch_for_mcu(${mcu_name} mcu_definition)
    if ("${mcu_definition}" STREQUAL "")
        message(WARNING "Unrecognized AVR MCU: '${mcu_name}'")
    endif()

    string(TOLOWER "${mcu_name}" mcu_name)
    target_compile_options(${target} PRIVATE "-mmcu=${mcu_name}")
    set_property(TARGET ${target} PROPERTY "CMAKEMBED_AVR_MCU" "${mcu_name}")
endfunction()

# Configure CMake to globally compile for the given AVR MCU
function(avr_set_compile_options mcu_name)
    _avr_get_arch_for_mcu(${mcu_name} mcu_definition)
    if ("${mcu_definition}" STREQUAL "")
        message(WARNING "Unrecognized AVR MCU: '${mcu_name}'")
    endif()

    string(TOLOWER "${mcu_name}" mcu_name)
    add_compile_options("-mmcu=${mcu_name}")
    set_property(GLOBAL PROPERTY "CMAKEMBED_AVR_MCU" "${mcu_name}")
endfunction()

# Add the default "avr-gcc" compile definitions of a given MCU to the desired
# target
function(avr_set_target_compile_definitions target mcu)
    _avr_get_gcc_default_definitions("${mcu}" definitions)
    target_compile_definitions(${target} PRIVATE ${definitions})
endfunction()

# Add the default "avr-gcc" compile definitions of a given MCU globally
function(avr_set_compile_definitions mcu)
    _avr_get_gcc_default_definitions("${mcu}" definitions)
    add_compile_definitions(${definitions})
endfunction()

# Configure the given target to build for the given MCU
function(avr_configure_target target mcu)
    avr_set_target_compile_options(${target} ${mcu})
    avr_set_target_compile_definitions(${target} ${mcu})
endfunction()

# Configure the build system globally for the give MCU
function(avr_configure mcu)
    avr_set_compile_options(${mcu})
    avr_set_compile_definitions(${mcu})
endfunction()
