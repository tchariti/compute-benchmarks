__attribute__((intel_reqd_sub_group_size(8)))__attribute__((reqd_work_group_size(8, 1, 1)))void kernel is_local_block_io_supported(global uchar* dst) {    uint lid = get_sub_group_local_id();    uchar val = (uchar)lid * 2;    __local uchar tmp_slm[8];    intel_sub_group_block_write_uc2(tmp_slm, (uchar2)(val));    barrier(CLK_LOCAL_MEM_FENCE);    uchar2 read = intel_sub_group_block_read_uc2(tmp_slm);    dst[lid] = read.s0 + 1;}
/* Build Log:

*/
