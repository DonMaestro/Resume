/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    unisims_ver_m_00000000000798704983_2301596894_init();
    unisims_ver_m_00000000000813751473_0227661056_init();
    work_m_00000000001302034747_3177209524_init();
    work_m_00000000001957992623_2705337095_init();
    work_m_00000000002654068659_2501825637_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002654068659_2501825637");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
