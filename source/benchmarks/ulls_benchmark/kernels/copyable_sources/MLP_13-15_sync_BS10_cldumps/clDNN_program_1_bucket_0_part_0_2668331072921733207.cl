
#if defined(cl_khr_fp16)
#pragma OPENCL EXTENSION cl_khr_fp16 : enable
#endif
#if !defined(cl_intel_subgroups) && defined(cl_khr_subgroups)
#pragma OPENCL EXTENSION cl_khr_subgroups : enable
#endif
#define __CAT(x, y) x##y
#define CAT(x, y) __CAT(x, y)
#define OFFSET_GLOBAL_PTR(elem_type, ptr, byte_offset) ((__global elem_type*)((__global char*)(ptr) + (byte_offset)))
#define MULTIPLY_OFFSET(elem_type, byte_offset) ((byte_offset) * sizeof(elem_type))
#if OPT_HINTS_SUPPORTED
# define ASSUME_HINT(x) __builtin_assume(x)
#else
# define ASSUME_HINT(x) do { } while (0)
#endif
#define unroll_for __attribute__((opencl_unroll_hint)) for
#define CEIL_DIV(a, b) (((a) + (b) - 1)/(b))
#define ALIGN(a, b) (CEIL_DIV(a, b) * (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define CLAMP(v,l,u) MAX((l),MIN((v),(u)))
#define MAKE_VECTOR_TYPE_IMPL_1(elem_type) elem_type
#define MAKE_VECTOR_TYPE_IMPL_2(elem_type) CAT(elem_type, 2)
#define MAKE_VECTOR_TYPE_IMPL_3(elem_type) CAT(elem_type, 3)
#define MAKE_VECTOR_TYPE_IMPL_4(elem_type) CAT(elem_type, 4)
#define MAKE_VECTOR_TYPE_IMPL_8(elem_type) CAT(elem_type, 8)
#define MAKE_VECTOR_TYPE_IMPL_16(elem_type) CAT(elem_type, 16)
#define MAKE_VECTOR_TYPE(elem_type, size) CAT(MAKE_VECTOR_TYPE_IMPL_, size)(elem_type)
#define AS_TYPE(type, val) CAT(as_, type)(val)
#define TYPE_SIZE_uchar 1
#define TYPE_SIZE_char 1
#define TYPE_SIZE_ushort 2
#define TYPE_SIZE_short 2
#define TYPE_SIZE_half 2
#define TYPE_SIZE_int 4
#define TYPE_SIZE_uint 4
#define TYPE_SIZE_float 4
#define TYPE_SIZE_ulong 8
#define TYPE_SIZE_long 8
#define TYPE_SIZE(type) CAT(TYPE_SIZE_, type)
#ifdef cl_intel_required_subgroup_size
#define REQD_SUB_GROUP_SIZE(sg_size) __attribute__((intel_reqd_sub_group_size(sg_size)))
#else
#define REQD_SUB_GROUP_SIZE(sg_size)
#endif

#define GET_DATA_INDEX(prefix, b, f, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (f)*CAT(prefix, _FEATURE_PITCH) + (b)*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_RAW(prefix, i0, i1, i2, i3) CAT(prefix, _OFFSET) + (i0)*CAT(prefix, _PITCHES)[0] + (i1)*CAT(prefix, _PITCHES)[1] + (i2)*CAT(prefix, _PITCHES)[2] + (i3)*CAT(prefix, _PITCHES)[3]
#define GET_DATA_INDEX_SAFE(prefix, b, f, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (f % CAT(prefix, _FEATURE_NUM))*CAT(prefix, _FEATURE_PITCH) + (b % CAT(prefix, _BATCH_NUM ))*CAT(prefix, _BATCH_PITCH)
 #define GET_DATA_INDEX_5D(prefix, b, f, z, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (f)*CAT(prefix, _FEATURE_PITCH) + (b)*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_5D_RAW(prefix, i0, i1, i2, i3, i4) CAT(prefix, _OFFSET) + (i0)*CAT(prefix, _PITCHES)[0] + (i1)*CAT(prefix, _PITCHES)[1] + (i2)*CAT(prefix, _PITCHES)[2] + (i3)*CAT(prefix, _PITCHES)[3] + (i4)*CAT(prefix, _PITCHES)[4]
#define GET_DATA_INDEX_5D_SAFE(prefix, b, f, z, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (z % CAT(prefix, _SIZE_Z ))*CAT(prefix, _Z_PITCH) + (f % CAT(prefix, _FEATURE_NUM))*CAT(prefix, _FEATURE_PITCH) + (b % CAT(prefix, _BATCH_NUM ))*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_6D(prefix, b, f, w, z, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (w)*CAT(prefix, _W_PITCH) + (f)*CAT(prefix, _FEATURE_PITCH) + (b)*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_6D_SAFE(prefix, b, f, w, z, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (z % CAT(prefix, _SIZE_Z ))*CAT(prefix, _Z_PITCH) + (w % CAT(prefix, _SIZE_W ))*CAT(prefix, _W_PITCH) + (f % CAT(prefix, _FEATURE_NUM))*CAT(prefix, _FEATURE_PITCH) + (b % CAT(prefix, _BATCH_NUM ))*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_6D_RAW(prefix, i0, i1, i2, i3, i4, i5) CAT(prefix, _OFFSET) + (i0)*CAT(prefix, _PITCHES)[0] + (i1)*CAT(prefix, _PITCHES)[1] + (i2)*CAT(prefix, _PITCHES)[2] + (i3)*CAT(prefix, _PITCHES)[3] + (i4)*CAT(prefix, _PITCHES)[4] + (i5)*CAT(prefix, _PITCHES)[5]
#define GET_DATA_INDEX_7D(prefix, b, f, u, w, z, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (w)*CAT(prefix, _W_PITCH) + (u)*CAT(prefix, _U_PITCH) + (f)*CAT(prefix, _FEATURE_PITCH) + (b)*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_7D_SAFE(prefix, b, f, u, w, z, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (z % CAT(prefix, _SIZE_Z ))*CAT(prefix, _Z_PITCH) + (w % CAT(prefix, _SIZE_W ))*CAT(prefix, _W_PITCH) + (u % CAT(prefix, _SIZE_U ))*CAT(prefix, _U_PITCH) + (f % CAT(prefix, _FEATURE_NUM))*CAT(prefix, _FEATURE_PITCH) + (b % CAT(prefix, _BATCH_NUM ))*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_7D_RAW(prefix, i0, i1, i2, i3, i4, i5, i6) CAT(prefix, _OFFSET) + (i0)*CAT(prefix, _PITCHES)[0] + (i1)*CAT(prefix, _PITCHES)[1] + (i2)*CAT(prefix, _PITCHES)[2] + (i3)*CAT(prefix, _PITCHES)[3] + (i4)*CAT(prefix, _PITCHES)[4] + (i5)*CAT(prefix, _PITCHES)[5] + (i6)*CAT(prefix, _PITCHES)[6]
#define GET_DATA_INDEX_8D(prefix, b, f, v, u, w, z, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (w)*CAT(prefix, _W_PITCH) + (u)*CAT(prefix, _U_PITCH) + (v)*CAT(prefix, _V_PITCH) + (f)*CAT(prefix, _FEATURE_PITCH) + (b)*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_8D_SAFE(prefix, b, f, v, u, w, z, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (z % CAT(prefix, _SIZE_Z ))*CAT(prefix, _Z_PITCH) + (w % CAT(prefix, _SIZE_W ))*CAT(prefix, _W_PITCH) + (u % CAT(prefix, _SIZE_U ))*CAT(prefix, _U_PITCH) + (v % CAT(prefix, _SIZE_V ))*CAT(prefix, _V_PITCH) + (f % CAT(prefix, _FEATURE_NUM))*CAT(prefix, _FEATURE_PITCH) + (b % CAT(prefix, _BATCH_NUM ))*CAT(prefix, _BATCH_PITCH)
#define GET_DATA_INDEX_8D_RAW(prefix, i0, i1, i2, i3, i4, i5, i6, i7) CAT(prefix, _OFFSET) + (i0)*CAT(prefix, _PITCHES)[0] + (i1)*CAT(prefix, _PITCHES)[1] + (i2)*CAT(prefix, _PITCHES)[2] + (i3)*CAT(prefix, _PITCHES)[3] + (i4)*CAT(prefix, _PITCHES)[4] + (i5)*CAT(prefix, _PITCHES)[5] + (i6)*CAT(prefix, _PITCHES)[6] + (i7)*CAT(prefix, _PITCHES)[7]
#define GET_DATA_BS_FYX_BSV8_INDEX(prefix, b, f, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((b) % (sub_group_size)) + (sub_group_size)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (f)*CAT(prefix, _FEATURE_PITCH) + ((b) / (sub_group_size))*CAT(prefix, _BATCH_PITCH) )
inline uint get_b_fs_yx_fsv_index(uint b, uint f, uint y, uint x,
 uint x_size, uint y_size, uint f_size, uint b_size,
 uint b_pad_before, uint b_pad_after,
 uint f_pad_before, uint f_pad_after,
 uint y_pad_before, uint y_pad_after,
 uint x_pad_before, uint x_pad_after, uint alignment) {
 const uint feature = f + f_pad_before;
 const uint fs = feature / alignment;
 const uint fsv = feature % alignment;
 const uint x_pitch = alignment;
 const uint y_pitch = x_pitch * (x_pad_before + x_size + x_pad_after);
 const uint total_f_size = f_pad_before + f_size + f_pad_after;
 const uint fs_pitch = y_pitch * (y_pad_before + y_size + y_pad_after);
 const uint b_pitch = fs_pitch * ((total_f_size + alignment - 1) / alignment);
 const uint output_offset = (b_pad_before + b) * b_pitch +
 fs * fs_pitch +
 (y_pad_before + y) * y_pitch +
 (x_pad_before + x) * x_pitch
 + fsv;
 return output_offset;
}
inline uint get_b_fs_yx_fsv_index_safe(uint b, uint f, uint y, uint x,
 uint x_size, uint y_size, uint f_size, uint b_size,
 uint b_pad_before, uint b_pad_after,
 uint f_pad_before, uint f_pad_after,
 uint y_pad_before, uint y_pad_after,
 uint x_pad_before, uint x_pad_after, uint alignment) {
 const uint f_mod = f_pad_before + (f % f_size);
 const uint fs = f_mod / alignment;
 const uint fsv = f_mod % alignment;
 const uint x_pitch = alignment;
 const uint y_pitch = x_pitch * (x_pad_before + x_size + x_pad_after);
 const uint total_f_size = f_pad_before + f_size + f_pad_after;
 const uint fs_pitch = y_pitch * (y_pad_before + y_size + y_pad_after);
 const uint b_pitch = fs_pitch * ((total_f_size + alignment - 1) / alignment);
 const uint output_offset = (b_pad_before + (b % b_size)) * b_pitch +
 fs * fs_pitch +
 (y_pad_before + (y % y_size)) * y_pitch +
 (x_pad_before + (x % x_size)) * x_pitch
 + fsv;
 return output_offset;
}
#define GET_DATA_B_FS_YX_FSV16_INDEX(prefix, b, f, y, x) get_b_fs_yx_fsv_index( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16)
#define GET_DATA_B_FS_YX_FSV16_INDEX_SAFE(prefix, b, f, y, x) get_b_fs_yx_fsv_index_safe( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16)
#define GET_DATA_B_FS_YX_FSV2_INDEX(prefix, b, f, y, x) get_b_fs_yx_fsv_index( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 2)
#define GET_DATA_B_FS_YX_FSV2_INDEX_SAFE(prefix, b, f, y, x) get_b_fs_yx_fsv_index_safe( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 2)
#define GET_DATA_B_FS_YX_FSV4_INDEX(prefix, b, f, y, x) get_b_fs_yx_fsv_index( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4)
#define GET_DATA_B_FS_YX_FSV4_INDEX_SAFE(prefix, b, f, y, x) get_b_fs_yx_fsv_index_safe( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4)
#define GET_DATA_B_FS_YX_FSV32_INDEX(prefix, b, f, y, x) get_b_fs_yx_fsv_index( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32)
#define GET_DATA_B_FS_YX_FSV32_INDEX_SAFE(prefix, b, f, y, x) get_b_fs_yx_fsv_index_safe( b, f, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_BATCH_NUM), CAT(prefix, _PAD_AFTER_BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32)
#define GET_DATA_FS_B_YX_FSV32_INDEX(prefix, b, f, y, x) get_fs_b_yx_fsv32_index( b, f, y, x, CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _BATCH_NUM))
#define GET_DATA_FS_B_YX_FSV32_INDEX_SAFE(prefix, b, f, y, x) get_fs_b_yx_fsv32_index_safe( b, f, y, x, CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM))
inline uint get_fs_b_yx_fsv32_index(uint b, uint f, uint y, uint x,
 uint x_pad_before, uint x_size, uint x_pad_after,
 uint y_pad_before, uint y_size, uint y_pad_after,
 uint f_pad_before,
 uint size_b)
{
 const uint feature_tile_size = 32;
 const uint x_total_size = x_pad_before + x_size + x_pad_after;
 const uint y_total_size = y_pad_before + y_size + y_pad_after;
 const uint real_x = x + x_pad_before;
 const uint real_y = y + y_pad_before;
 const uint real_f = f + f_pad_before;
 const uint x_pitch = feature_tile_size;
 const uint y_pitch = x_pitch * x_total_size;
 const uint b_pitch = y_pitch * y_total_size;
 const uint f_tile_pitch = b_pitch * size_b;
 const uint feature_tile_number = real_f / feature_tile_size;
 const uint feature_local_number = real_f % feature_tile_size;
 size_t index = 0;
 index += feature_tile_number * f_tile_pitch;
 index += b * b_pitch;
 index += real_y * y_pitch;
 index += real_x * x_pitch;
 index += feature_local_number;
 return index;
}
inline uint get_fs_b_yx_fsv32_index_safe(uint b, uint f, uint y, uint x,
 uint x_pad_before, uint x_size, uint x_pad_after,
 uint y_pad_before, uint y_size, uint y_pad_after,
 uint f_pad_before, uint f_size,
 uint size_b)
{
 const uint feature_tile_size = 32;
 const uint x_total_size = x_pad_before + x_size + x_pad_after;
 const uint y_total_size = y_pad_before + y_size + y_pad_after;
 const uint real_x = (x % x_size) + x_pad_before;
 const uint real_y = (y % y_size) + y_pad_before;
 const uint real_f = (f % f_size) + f_pad_before;
 const uint x_pitch = feature_tile_size;
 const uint y_pitch = x_pitch * x_total_size;
 const uint b_pitch = y_pitch * y_total_size;
 const uint f_tile_pitch = b_pitch * size_b;
 const uint feature_tile_number = real_f / feature_tile_size;
 const uint feature_local_number = real_f % feature_tile_size;
 size_t index = 0;
 index += feature_tile_number * f_tile_pitch;
 index += b * b_pitch;
 index += real_y * y_pitch;
 index += real_x * x_pitch;
 index += feature_local_number;
 return index;
}
#define GET_DATA_B_FS_ZYX_FSV2_INDEX(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 2)
#define GET_DATA_B_FS_ZYX_FSV2_INDEX_SAFE(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 2)
#define GET_DATA_B_FS_ZYX_FSV4_INDEX(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4)
#define GET_DATA_B_FS_ZYX_FSV4_INDEX_SAFE(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4)
#define GET_DATA_B_FS_ZYX_FSV16_INDEX(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16)
#define GET_DATA_B_FS_ZYX_FSV16_INDEX_SAFE(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16)
#define GET_DATA_B_FS_ZYX_FSV32_INDEX(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32)
#define GET_DATA_B_FS_ZYX_FSV32_INDEX_SAFE(prefix, b, f, z, y, x) get_b_fs_zyx_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32)
inline uint get_b_fs_zyx_fsv_index(uint b, uint f, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint f_size,
 uint f_pad_before, uint f_pad_after,
 uint z_pad_before, uint z_pad_after,
 uint y_pad_before, uint y_pad_after,
 uint x_pad_before, uint x_pad_after,
 uint alignment)
{
 const uint feature = f + f_pad_before;
 const uint fs = feature / alignment;
 const uint fsv = feature % alignment;
 const uint x_pitch = alignment;
 const uint y_pitch = x_pitch * (x_pad_before + x_size + x_pad_after);
 const uint z_pitch = y_pitch * (y_pad_before + y_size + y_pad_after);
 const uint fs_pitch = z_pitch * (z_pad_before + z_size + z_pad_after);
 const uint total_f_size = f_pad_before + f_size + f_pad_after;
 const uint b_pitch = fs_pitch * ((total_f_size + alignment - 1) / alignment);
 const uint output_offset = b * b_pitch +
 fs * fs_pitch +
 (z_pad_before + z) * z_pitch +
 (y_pad_before + y) * y_pitch +
 (x_pad_before + x) * x_pitch
 + fsv;
 return output_offset;
}
inline uint get_b_fs_zyx_fsv_index_safe(uint b, uint f, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint f_size,
 uint f_pad_before, uint f_pad_after,
 uint z_pad_before, uint z_pad_after,
 uint y_pad_before, uint y_pad_after,
 uint x_pad_before, uint x_pad_after,
 uint alignment) {
 const uint f_mod = f_pad_before + (f % f_size);
 const uint fs = f_mod / alignment;
 const uint fsv = f_mod % alignment;
 const uint x_pitch = alignment;
 const uint y_pitch = x_pitch * (x_pad_before + x_size + x_pad_after);
 const uint z_pitch = y_pitch * (y_pad_before + y_size + y_pad_after);
 const uint fs_pitch = z_pitch * (z_pad_before + z_size + z_pad_after);
 const uint total_f_size = f_pad_before + f_size + f_pad_after;
 const uint b_pitch = fs_pitch * ((total_f_size + alignment - 1) / alignment);
 const uint output_offset = b * b_pitch +
 fs * fs_pitch +
 (z_pad_before + (z % z_size)) * z_pitch +
 (y_pad_before + (y % y_size)) * y_pitch +
 (x_pad_before + (x % x_size)) * x_pitch
 + fsv;
 return output_offset;
}
inline uint get_bs_fs_zyx_bsv_fsv_index_safe(uint b, uint f, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint f_size, uint b_size,
 uint f_pad_before, uint f_pad_after,
 uint z_pad_before, uint z_pad_after,
 uint y_pad_before, uint y_pad_after,
 uint x_pad_before, uint x_pad_after, uint alignmentB, uint alignmentF) {
 const uint b_mod = b % b_size;
 const uint f_mod = f_pad_before + (f % f_size);
 const uint fs = f_mod / alignmentF;
 const uint fsv = f_mod % alignmentF;
 const uint bs = b_mod / alignmentB;
 const uint bsv = b_mod % alignmentB;
 const uint x_pitch = alignmentF * alignmentB;
 const uint y_pitch = x_pitch * (x_pad_before + x_size + x_pad_after);
 const uint z_pitch = y_pitch * (y_pad_before + y_size + y_pad_after);
 const uint total_f_size = f_pad_before + f_size + f_pad_after;
 const uint fs_pitch = z_pitch * (z_pad_before + z_size + z_pad_after);
 const uint b_pitch = fs_pitch * ((total_f_size + alignmentF - 1) / alignmentF);
 const uint output_offset = (bs * b_pitch) + (bsv * alignmentF) +
 fs * fs_pitch +
 (z_pad_before + (z % z_size)) * z_pitch +
 (y_pad_before + (y % y_size)) * y_pitch +
 (x_pad_before + (x % x_size)) * x_pitch
 + fsv;
 return output_offset;
}
inline uint get_bs_fs_zyx_bsv_fsv_index(uint b, uint f, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint f_size,
 uint f_pad_before, uint f_pad_after,
 uint z_pad_before, uint z_pad_after,
 uint y_pad_before, uint y_pad_after,
 uint x_pad_before, uint x_pad_after,
 uint b_alignment, uint f_alignment) {
 const uint feature = f + f_pad_before;
 const uint fs = feature / f_alignment;
 const uint fsv = feature % f_alignment;
 const uint bs = b / b_alignment;
 const uint bsv = b % b_alignment;
 const uint bsv_pitch = f_alignment;
 const uint x_pitch = bsv_pitch * b_alignment;
 const uint y_pitch = x_pitch * (x_pad_before + x_size + x_pad_after);
 const uint z_pitch = y_pitch * (y_pad_before + y_size + y_pad_after);
 const uint fs_pitch = z_pitch * (z_pad_before + z_size + z_pad_after);
 const uint total_f_size = f_pad_before + f_size + f_pad_after;
 const uint bs_pitch = fs_pitch * ((total_f_size + f_alignment - 1) / f_alignment);
 const uint output_offset = bs * bs_pitch +
 fs * fs_pitch +
 (z_pad_before + z) * z_pitch +
 (y_pad_before + y) * y_pitch +
 (x_pad_before + x) * x_pitch +
 bsv * bsv_pitch
 + fsv;
 return output_offset;
}
#define GET_DATA_BS_FS_YX_BSV16_FSV16_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 16)
#define GET_DATA_BS_FS_YX_BSV16_FSV32_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 32)
#define GET_DATA_BS_FS_ZYX_BSV32_FSV32_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 32)
#define GET_DATA_BS_FS_YX_BSV32_FSV32_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 32)
#define GET_DATA_BS_FS_YX_BSV4_FSV4_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4, 4)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV4_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 4)
#define GET_DATA_BS_FS_YX_BSV16_FSV4_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 4)
#define GET_DATA_BS_FS_ZYX_BSV8_FSV4_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 4)
#define GET_DATA_BS_FS_YX_BSV8_FSV4_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z),  CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 4)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV2_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 2)
#define GET_DATA_BS_FS_YX_BSV16_FSV2_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 2)
#define GET_DATA_BS_FS_ZYX_BSV8_FSV2_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 2)
#define GET_DATA_BS_FS_YX_BSV8_FSV2_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 2)
#define GET_DATA_BS_FS_YX_BSV4_FSV2_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4, 2)
#define GET_DATA_BS_FS_ZYX_BSV32_FSV16_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 16)
#define GET_DATA_BS_FS_YX_BSV32_FSV16_INDEX(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 16)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV32_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 32)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV16_INDEX(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 16)
#define GET_DATA_BS_FS_YX_BSV16_FSV16_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 16)
#define GET_DATA_BS_FS_ZYX_BSV32_FSV32_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 32)
#define GET_DATA_BS_FS_YX_BSV32_FSV32_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z),  CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 32)
#define GET_DATA_BS_FS_YX_BSV4_FSV4_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4, 4)
#define GET_DATA_BS_FS_YX_BSV16_FSV4_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 4)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV4_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 4)
#define GET_DATA_BS_FS_YX_BSV8_FSV4_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 4)
#define GET_DATA_BS_FS_ZYX_BSV8_FSV4_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 4)
#define GET_DATA_BS_FS_YX_BSV16_FSV2_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 2)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV2_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 2)
#define GET_DATA_BS_FS_YX_BSV8_FSV2_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 2)
#define GET_DATA_BS_FS_ZYX_BSV8_FSV2_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 8, 2)
#define GET_DATA_BS_FS_YX_BSV4_FSV2_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 4, 2)
#define GET_DATA_BS_FS_ZYX_BSV32_FSV16_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 16)
#define GET_DATA_BS_FS_YX_BSV32_FSV16_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM),  CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 32, 16)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV32_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 32)
#define GET_DATA_BS_FS_YX_BSV16_FSV32_INDEX_SAFE(prefix, b, f, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 32)
#define GET_DATA_BS_FS_ZYX_BSV16_FSV16_INDEX_SAFE(prefix, b, f, z, y, x) get_bs_fs_zyx_bsv_fsv_index_safe( b, f, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _FEATURE_NUM), CAT(prefix, _BATCH_NUM), CAT(prefix, _PAD_BEFORE_FEATURE_NUM), CAT(prefix, _PAD_AFTER_FEATURE_NUM), CAT(prefix, _PAD_BEFORE_SIZE_Z), CAT(prefix, _PAD_AFTER_SIZE_Z), CAT(prefix, _PAD_BEFORE_SIZE_Y), CAT(prefix, _PAD_AFTER_SIZE_Y), CAT(prefix, _PAD_BEFORE_SIZE_X), CAT(prefix, _PAD_AFTER_SIZE_X), 16, 16)

#define GET_FILTER_OS_IS_YX_ISV_OSV_INDEX(prefix, o, i, y, x, osv, isv) get_os_is_zyx_isv_osv_index( o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), osv, isv )
#define GET_FILTER_OS_IS_ZYX_ISV_OSV_INDEX(prefix, o, i, z, y, x, osv, isv) get_os_is_zyx_isv_osv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), osv, isv )
#define GET_FILTER_IS_OS_ZYX_ISV16_OSV16_INDEX(prefix, o, i, z, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + (z)*(sub_group_size)*CAT(prefix, _Z_PITCH) + ((i) % (sub_group_size)) + ((o) / (sub_group_size))*(sub_group_size)*CAT(prefix, _OFM_PITCH) + ((i) / (sub_group_size))*CAT(prefix, _IFM_PITCH) )
#define GET_FILTER_IS_OS_YX_ISV16_OSV16_INDEX(prefix, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + ((i) % (sub_group_size)) + ((o) / (sub_group_size))*(sub_group_size)*CAT(prefix, _OFM_PITCH) + ((i) / (sub_group_size))*CAT(prefix, _IFM_PITCH) )
#define GET_FILTER_IS_OS_YX_ISV16_OSV8_INDEX(prefix, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + ((i) % (sub_group_size)) + ((o) / (sub_group_size))*(sub_group_size)*CAT(prefix, _OFM_PITCH) + ((i) / (sub_group_size))*CAT(prefix, _IFM_PITCH) )
#define GET_FILTER_OS_IS_YX_ISV8_OSV16_ISV2_INDEX(prefix, o, i, y, x, sub_group_size) get_os_is_zyx_isv8_osv16_isv2_index( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _GROUPS_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _OFFSET) )
#define GET_FILTER_OS_IS_ZYX_ISV8_OSV16_ISV2_INDEX(prefix, o, i, z, y, x, sub_group_size) get_os_is_zyx_isv8_osv16_isv2_index( 0, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _GROUPS_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _OFFSET) )
inline uint get_os_is_zyx_isv_osv_index(uint o, uint i, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint i_size, uint o_size, uint osv_size, uint isv_size)
{
 const uint isv = i % isv_size;
 const uint osv = o % osv_size;
 const uint is = i / isv_size;
 const uint os = o / osv_size;
 const uint x_pitch = osv_size * isv_size;
 const uint y_pitch = x_pitch * x_size;
 const uint z_pitch = y_pitch * y_size;
 const uint is_pitch = z_pitch * z_size;
 const uint os_pitch = is_pitch * ((i_size + isv_size - 1) / isv_size);
 const uint output_offset =
 osv +
 isv * osv_size +
 x * x_pitch +
 y * y_pitch +
 z * z_pitch +
 is * is_pitch +
 os * os_pitch;
 return output_offset;
}
inline uint get_os_is_zyx_osv_isv_index(uint o, uint i, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint i_size, uint o_size, uint osv_size, uint isv_size)
{
 const uint isv = i % isv_size;
 const uint osv = o % osv_size;
 const uint is = i / isv_size;
 const uint os = o / osv_size;
 const uint x_pitch = osv_size * isv_size;
 const uint y_pitch = x_pitch * x_size;
 const uint z_pitch = y_pitch * y_size;
 const uint is_pitch = z_pitch * z_size;
 const uint os_pitch = is_pitch * ((i_size + isv_size - 1) / isv_size);
 const uint output_offset =
 isv +
 osv * isv_size +
 x * x_pitch +
 y * y_pitch +
 z * z_pitch +
 is * is_pitch +
 os * os_pitch;
 return output_offset;
}
inline uint get_g_os_is_zyx_osv_isv_index(uint g, uint o, uint i, uint z, uint y, uint x,
 uint x_size, uint y_size, uint z_size, uint i_size, uint o_size, uint osv_size, uint isv_size)
{
 const uint isv = i % isv_size;
 const uint osv = o % osv_size;
 const uint is = i / isv_size;
 const uint os = o / osv_size;
 const uint x_pitch = osv_size * isv_size;
 const uint y_pitch = x_pitch * x_size;
 const uint z_pitch = y_pitch * y_size;
 const uint is_pitch = z_pitch * z_size;
 const uint os_pitch = is_pitch * ((i_size + isv_size - 1) / isv_size);
 const uint g_pitch = os_pitch * ((o_size + osv_size - 1) / osv_size);
 const uint output_offset =
 isv +
 osv * isv_size +
 x * x_pitch +
 y * y_pitch +
 z * z_pitch +
 is * is_pitch +
 os * os_pitch +
 g * g_pitch;
 return output_offset;
}
#define GET_FILTER_G_OS_IS_ZYX_OSV16_ISV16_INDEX(prefix, g, o, i, z, y, x) get_g_os_is_zyx_osv_isv_index( g, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 16, 16)
#define GET_FILTER_OS_IS_YX_OSV16_ISV2_INDEX(prefix, o, i, y, x) get_os_is_zyx_osv_isv_index( o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 16, 2)
#define GET_FILTER_OS_IS_YX_OSV16_ISV16_INDEX(prefix, o, i, y, x) get_os_is_zyx_osv_isv_index( o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 16,  16)
#define GET_FILTER_OS_IS_ZYX_OSV16_ISV16_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osv_isv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 16, 16)
#define GET_FILTER_OS_IS_ZYX_OSV32_ISV16_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osv_isv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 32, 16)
#define GET_FILTER_OS_IS_ZYX_OSV64_ISV16_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osv_isv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 64, 16)
#define GET_FILTER_G_OS_IS_YX_ISV8_OSV16_ISV2_INDEX(prefix, g, o, i, y, x, sub_group_size) get_os_is_zyx_isv8_osv16_isv2_index( g, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _GROUPS_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _OFFSET) )
#define GET_FILTER_G_OS_IS_ZYX_ISV8_OSV16_ISV2_INDEX(prefix, g, o, i, z, y, x, sub_group_size) get_os_is_zyx_isv8_osv16_isv2_index( g, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _GROUPS_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _OFFSET) )
inline uint get_os_is_zyx_isv8_osv16_isv2_index(uint g, uint o, uint i, uint z, uint y, uint x, uint x_size, uint y_size, uint z_size,
 uint g_size, uint o_size, uint i_size, uint offset)
{
 const uint group_offset = g * o_size * i_size * z_size * y_size * x_size;
 const uint xyz_offset = (x + y * x_size + z * x_size * y_size)* 8*16*2;
 const uint i2_val = i % 2;
 const uint i2_slice = i / 2;
 const uint i8_v = i2_slice % 8;
 const uint i8_s = i2_slice / 8;
 const uint i2_offset = i2_val;
 const uint o_offset = (o % 16)*2 + (o / 16) * 16 * i_size * x_size * y_size * z_size;
 const uint i8_offset = 8*16*2* x_size*y_size*z_size * i8_s + 16*2*i8_v;
 const size_t idx = offset + group_offset + xyz_offset + i2_offset + i8_offset + o_offset;
 return idx;
}
inline uint get_os_zyxi_osv16_index(uint o, uint i, uint z, uint y, uint x, uint i_size, uint o_size, uint x_size, uint y_size, uint z_size)
{
 const size_t idx = o%16 + (o / 16)*i_size*x_size*y_size*z_size*16 +
 16 *(i+ x*i_size + y*i_size*x_size + z*i_size*x_size*y_size);
 return idx;
}
#define GET_FILTER_OS_ZYXI_OSV16(prefix, o, i, z, y, x) get_os_zyxi_osv16_index( o, i, z, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z))
#define GET_FILTER_GOIYX(prefix, g, o, i, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + (o)*CAT(prefix, _OFM_PITCH) + (g)*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_GIOYX(prefix, g, o, i, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + (o)*CAT(prefix, _OFM_PITCH) + (g)*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_GIOYX_SAFE(prefix, g, o, i, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (i % CAT(prefix, _IFM_NUM))*CAT(prefix, _IFM_PITCH) + (o % CAT(prefix, _OFM_NUM))*CAT(prefix, _OFM_PITCH) + (g % CAT(prefix, _GROUPS_NUM))*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_GOIYX_SAFE(prefix, g, o, i, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (i % CAT(prefix, _IFM_NUM))*CAT(prefix, _IFM_PITCH) + (o % CAT(prefix, _OFM_NUM))*CAT(prefix, _OFM_PITCH) + (g % CAT(prefix, _GROUPS_NUM))*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_INDEX(prefix, g, o, i, y, x) GET_FILTER_GOIYX(prefix, g, o, i, y, x)
#define GET_FILTER_INDEX_SAFE(prefix, g, o, i, y, x) GET_FILTER_GOIYX_SAFE(prefix, g, o, i, y, x)
#define GET_FILTER_GOIZYX(prefix, g, o, i, z, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + (o)*CAT(prefix, _OFM_PITCH) + (g)*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_GOIZYX_SAFE(prefix, g, o, i, z, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (z % CAT(prefix, _SIZE_Z ))*CAT(prefix, _Z_PITCH) + (i % CAT(prefix, _IFM_NUM))*CAT(prefix, _IFM_PITCH) + (o % CAT(prefix, _OFM_NUM))*CAT(prefix, _OFM_PITCH) + (g % CAT(prefix, _GROUPS_NUM))*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_GIOZYX(prefix, g, o, i, z, y, x) CAT(prefix, _OFFSET) + (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + (o)*CAT(prefix, _OFM_PITCH) + (g)*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_GIOZYX_SAFE(prefix, g, o, i, z, y, x) CAT(prefix, _OFFSET) + (x % CAT(prefix, _SIZE_X ))*CAT(prefix, _X_PITCH) + (y % CAT(prefix, _SIZE_Y ))*CAT(prefix, _Y_PITCH) + (z % CAT(prefix, _SIZE_Z ))*CAT(prefix, _Z_PITCH) + (i % CAT(prefix, _IFM_NUM))*CAT(prefix, _IFM_PITCH) + (o % CAT(prefix, _OFM_NUM))*CAT(prefix, _OFM_PITCH) + (g % CAT(prefix, _GROUPS_NUM))*CAT(prefix, _GROUPS_PITCH)
#define GET_FILTER_INDEX_5D(prefix, g, o, i, z, y, x) GET_FILTER_GOIZYX(prefix, g, o, i, z, y, x)
#define GET_FILTER_INDEX_5D_SAFE(prefix, g, o, i, z, y, x) GET_FILTER_GOIZYX_SAFE(prefix, g, o, i, z, y, x)
#define GET_FILTER_OS_IYX_OSV_INDEX(prefix, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + ((o) / (sub_group_size))*CAT(prefix, _OFM_PITCH) )
#define GET_FILTER_OS_IYX_OSV_ROTATE_180_INDEX(prefix, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((o) % (sub_group_size)) + (sub_group_size)*( (CAT(prefix, _SIZE_X ) - x - 1)*CAT(prefix, _X_PITCH) + (CAT(prefix, _SIZE_Y ) - y - 1)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + ((o) / (sub_group_size))*CAT(prefix, _OFM_PITCH) )
inline uint get_gi_yxs_os_yxsv2_osv_index(uint g, uint o, uint i, uint y, uint x, uint x_size, uint g_pitch, uint i_pitch,
 uint y_pitch, uint x_pitch, uint offset, uint sub_group_size)
{
 const uint aligned_ofm_line = x_pitch;
 const uint ifm_height_pitch = (i_pitch/aligned_ofm_line);
 const uint dst_height = i*ifm_height_pitch + y*x_size + x;
 const uint base_filter_index = y*x_size + x;
 const uint aligned_height = dst_height & 0xfffffffe;
 const uint base_filter_odd = (base_filter_index & 0x1);

 uint slice_id = o / sub_group_size;
 uint id_in_slice = o % sub_group_size;
 uint slice_pitch = 2*sub_group_size;
 uint offset_in_slice = (int)(sub_group_size*base_filter_odd);
 const uint in_line = (slice_pitch*slice_id + offset_in_slice + id_in_slice);
 size_t idx = offset + aligned_height*aligned_ofm_line + in_line;
 idx += g * g_pitch;
 return idx;
}
#define GET_FILTER_I_YXS_OS_YXSV2_OSV_INDEX(prefix, o, i, y, x, sub_group_size) get_gi_yxs_os_yxsv2_osv_index( 0, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _GROUPS_PITCH), CAT(prefix, _IFM_PITCH), CAT(prefix, _Y_PITCH), CAT(prefix, _X_PITCH), CAT(prefix, _OFFSET), sub_group_size)
inline uint get_giy_xs_os_xsv2_osv_index(uint g, uint o, uint i, uint y, uint x, uint x_size, uint g_pitch,
 uint i_pitch, uint y_pitch, uint x_pitch, uint offset, uint sub_group_size)
{
 const uint aligned_ofm_line = x_pitch;
 const uint ifm_height_pitch = (i_pitch/aligned_ofm_line);
 const uint aligned_x_line = y_pitch / x_pitch;
 const uint dst_height = i*ifm_height_pitch + y*aligned_x_line + x;
 const uint base_filter_index = x;
 const uint aligned_height = dst_height & 0xfffffffe;
 const uint base_filter_odd = (base_filter_index & 0x1);
 uint slice_id = o / sub_group_size;
 uint id_in_slice = o % sub_group_size;
 uint slice_pitch = 2*sub_group_size;
 uint offset_in_slice = (int)(sub_group_size*base_filter_odd);
 const bool last_line_in_base_filter = (x == (x_size - 1));
 if (last_line_in_base_filter && base_filter_odd == 0)
 {
 const uint element_in_slice = 32;
 slice_id = o / element_in_slice;
 id_in_slice = o % element_in_slice;
 slice_pitch = 2*element_in_slice;
 offset_in_slice = 0;
 }
 const uint in_line = (slice_pitch*slice_id + offset_in_slice + id_in_slice);
 size_t idx = offset + aligned_height*aligned_ofm_line + in_line;
 idx += g * g_pitch;
 return idx;
}
#define GET_FILTER_IY_XS_OS_XSV2_OSV_INDEX(prefix, o, i, y, x, sub_group_size) get_giy_xs_os_xsv2_osv_index( 0, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _GROUPS_PITCH), CAT(prefix, _IFM_PITCH), CAT(prefix, _Y_PITCH), CAT(prefix, _X_PITCH), CAT(prefix, _OFFSET), sub_group_size)
inline uint get_is_os_zyx_isa8_osv8_isv2_index(uint o, uint i, uint z, uint y, uint x, uint size_x,
 uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv2_idx = i % 2;
 const uint osv_idx = o % 8;
 const uint isv1_idx = (i / 2) % 8;
 const uint is_idx = i / 16;
 const uint os_idx = o / 8;
 const uint of_8_aligned = ((size_ofm + 7) / 8);
 size_t idx = offset +
 isv2_idx +
 osv_idx * 2 +
 isv1_idx * 8 * 2 +
 x * 8 * 8 * 2 +
 y * size_x * 8 * 8 * 2 +
 z * size_y * size_x * 8 * 8 * 2 +
 os_idx * size_z * size_y * size_x * 8 * 8 * 2 +
 is_idx * of_8_aligned * size_z * size_y * size_x * 8 * 8 * 2;
 return idx;
}
inline uint get_is_os_zyx_isa8_osv8_isv4_index(uint o, uint i, uint z, uint y, uint x, uint size_x,
 uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv2_idx = i % 4;
 const uint osv_idx = o % 8;
 const uint isv1_idx = (i / 4) % 8;
 const uint is_idx = i / 32;
 const uint os_idx = o / 8;
 const uint of_8_aligned = ((size_ofm + 7) / 8);
 size_t idx = offset +
 isv2_idx +
 osv_idx * 4 +
 isv1_idx * 8 * 4 +
 x * 8 * 8 * 4 +
 y * size_x * 8 * 8 * 4 +
 z * size_y * size_x * 8 * 8 * 4 +
 os_idx * size_z * size_y * size_x * 8 * 8 * 4 +
 is_idx * of_8_aligned * size_z * size_y * size_x * 8 * 8 * 4;
 return idx;
}
inline uint get_g_os_is_zyx_isa_osv_isv_index(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset,
 uint isa, uint osv, uint isv)
{
 const uint isv2_idx = i % isv;
 const uint osv_idx = o % osv;
 const uint isv1_idx = (i / isv) % isa;
 const uint is_idx = i / (isa * isv);
 const uint os_idx = o / osv;
 const uint if_aligned = ((size_ifm + (isa * isv) - 1) / (isa * isv));
 const uint of_aligned = ((size_ofm + (osv - 1)) / osv);
 size_t idx = offset +
 isv2_idx +
 osv_idx * isv +
 isv1_idx * osv * isv +
 x * isa * osv * isv +
 y * size_x * isa * osv * isv +
 z * size_y * size_x * isa * osv * isv +
 is_idx * size_z * size_y * size_x * isa * osv * isv +
 os_idx * if_aligned * size_z * size_y * size_x * isa * osv * isv +
 g * of_aligned * if_aligned * size_z * size_y * size_x * isa * osv * isv;
 return idx;
}
#define GET_FILTER_G_OS_IS_ZYX_ISA_OSV_ISV_INDEX(prefix, g, o, i, z, y, x, isa, osv, isv) get_g_os_is_zyx_isa_osv_isv_index( g, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET), isa, osv, isv)
#define GET_FILTER_OS_IS_ZYX_ISA8_OSV8_ISV2_INDEX(prefix, o, i, z, y, x) GET_FILTER_G_OS_IS_ZYX_ISA_OSV_ISV_INDEX(prefix, 0, o, i, z, y, x, 8, 8, 2)
#define GET_FILTER_G_OS_IS_ZYX_ISA8_OSV8_ISV2_INDEX(prefix, g, o, i, z, y, x) GET_FILTER_G_OS_IS_ZYX_ISA_OSV_ISV_INDEX(prefix, g, o, i, z, y, x, 8, 8, 2)
#define GET_FILTER_G_OS_IS_ZYX_ISA8_OSV8_ISV4_INDEX(prefix, g, o, i, z, y, x) GET_FILTER_G_OS_IS_ZYX_ISA_OSV_ISV_INDEX(prefix, g, o, i, z, y, x, 8, 8, 4)
#define GET_FILTER_IS_OS_ZYX_ISA8_OSV8_ISV2_INDEX(prefix, o, i, z, y, x) get_is_os_zyx_isa8_osv8_isv2_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_IS_OS_ZYX_ISA8_OSV8_ISV4_INDEX(prefix, o, i, z, y, x) get_is_os_zyx_isa8_osv8_isv4_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_g_os_is_yx_isa8_osv8_isv4_index(uint g, uint o, uint i, uint y, uint x, uint size_x,
 uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv2_idx = i % 4;
 const uint osv_idx = o % 8;
 const uint isv1_idx = (i / 4) % 8;
 const uint is_idx = i / 32;
 const uint os_idx = o / 8;
 const uint if_32_aligned = ((size_ifm + 31) / 32);
 const uint of_8_aligned = ((size_ofm + 7) / 8);
 size_t idx = offset +
 isv2_idx +
 osv_idx * 4 +
 isv1_idx * 8 * 4 +
 x * 8 * 8 * 4 +
 y * size_x * 8 * 8 * 4 +
 is_idx * size_y * size_x * 4 * 8 * 8 +
 os_idx * if_32_aligned * size_y * size_x * 4 * 8 * 8 +
 g * of_8_aligned * if_32_aligned * size_y * size_x * 4 * 8 * 8;
 return idx;
}
#define GET_FILTER_G_OS_IS_YX_ISA8_OSV8_ISV4_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_isa8_osv8_isv4_index( g, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_ISA8_OSV8_ISV4_INDEX(prefix, o, i, y, x) get_g_os_is_yx_isa8_osv8_isv4_index( 0, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_g_os_is_yx_isa8_osv8_isv2_index(uint g, uint o, uint i, uint y, uint x, uint size_x,
 uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv2_idx = i % 2;
 const uint osv_idx = o % 8;
 const uint isv1_idx = (i / 2) % 8;
 const uint is_idx = i / 16;
 const uint os_idx = o / 8;
 const uint if_16_aligned = ((size_ifm + 15) / 16);
 const uint of_8_aligned = ((size_ofm + 7) / 8);
 size_t idx = offset +
 isv2_idx +
 osv_idx * 2 +
 isv1_idx * 8 * 2 +
 x * 8 * 8 * 2 +
 y * size_x * 8 * 8 * 2 +
 is_idx * size_y * size_x * 2 * 8 * 8 +
 os_idx * if_16_aligned * size_y * size_x * 2 * 8 * 8 +
 g * of_8_aligned * if_16_aligned * size_y * size_x * 2 * 8 * 8;
 return idx;
}
#define GET_FILTER_G_OS_IS_YX_ISA8_OSV8_ISV2_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_isa8_osv8_isv2_index( g, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_ISA8_OSV8_ISV2_INDEX(prefix, o, i, y, x) get_g_os_is_yx_isa8_osv8_isv2_index( 0, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_is_os_yx_isa8_osv8_isv2_index(uint o, uint i, uint y, uint x, uint size_x,
 uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
	const uint isv2_idx = i % 2;
	const uint osv_idx = o % 8;
	const uint isv1_idx = (i / 2) % 8;
	const uint is_idx = i / 16;
	const uint os_idx = o / 8;
 const uint of_8_aligned = ((size_ofm + 7) / 8);
	size_t idx = offset +
 isv2_idx +
 osv_idx * 2 +
 isv1_idx * 8 * 2 +
 x * 8 * 8 * 2 +
 y * size_x * 8 * 8 * 2 +
 os_idx * size_y * size_x * 2 * 8 * 8 +
 is_idx * of_8_aligned * size_y * size_x * 2 * 8 * 8;
 return idx;
}
#define GET_FILTER_IS_OS_YX_ISA8_OSV8_ISV2_INDEX(prefix, o, i, y, x) get_is_os_yx_isa8_osv8_isv2_index( o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_is_os_yx_isa8_osv8_isv4_index(uint o, uint i, uint y, uint x, uint size_x,
 uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
	const uint isv2_idx = i % 4;
	const uint osv_idx = o % 8;
	const uint isv1_idx = (i / 4) % 8;
	const uint is_idx = i / 32;
	const uint os_idx = o / 8;
 const uint of_8_aligned = ((size_ofm + 7) / 8);
	size_t idx = offset +
 isv2_idx +
 osv_idx * 4 +
 isv1_idx * 8 * 4 +
 x * 8 * 8 * 4 +
 y * size_x * 8 * 8 * 4 +
 os_idx * size_y * size_x * 4 * 8 * 8 +
 is_idx * of_8_aligned * size_y * size_x * 4 * 8 * 8;
 return idx;
}
#define GET_FILTER_IS_OS_YX_ISA8_OSV8_ISV4_INDEX(prefix, o, i, y, x) get_is_os_yx_isa8_osv8_isv4_index( o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_os_is_zyx_isa8_osv8_isv4_index(uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z,
 uint size_ifm, uint size_ofm, uint offset)
{
 const uint ifm_slices = (size_ifm + 31)/32;
 const uint isv2_idx = i % 4;
 const uint osv_idx = o % 8;
 const uint isv1_idx = (i / 4) % 8;
 const uint is_idx = i / 32;
 const uint os_idx = o / 8;
 size_t idx = offset + isv2_idx + 4 * (osv_idx + 8 * isv1_idx);
 idx += x * 4 * 8 * 8;
 idx += y * size_x * 4 * 8 * 8;
 idx += z * size_y * size_x * 4 * 8 * 8;
 idx += is_idx * size_z * size_y * size_x * 4 * 8 * 8;
 idx += os_idx * ifm_slices * size_z * size_y * size_x * 4 * 8 * 8;
 return idx;
}
#define GET_FILTER_OS_IS_ZYX_ISA8_OSV8_ISV4_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_isa8_osv8_isv4_index( o, i, z, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_os_is_yx_isa8_osv16_isv4_index(uint o, uint i, uint y, uint x, uint size_x, uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint f_32_aligned = ((size_ifm + 31)/32) * 32;
 const uint isv2_idx = i % 4;
 const uint osv_idx = o % 16;
 const uint isv1_idx = (i / 4) % 8;
 const uint is_idx = i / 32;
 const uint os_idx = o / 16;
 size_t idx = offset + isv2_idx + 4 * (osv_idx + 16 * isv1_idx);
 idx += x * 4 * 8 * 16;
 idx += y * size_x * 4 * 8 * 16;
 idx += is_idx * size_y * size_x * 4 * 8 * 16;
 idx += os_idx * (f_32_aligned/32) * size_y * size_x * 4 * 8 * 16;
 return idx;
}
#define GET_FILTER_OS_IS_YX_ISA8_OSV16_ISV4_INDEX(prefix, o, i, y, x) get_os_is_yx_isa8_osv16_isv4_index( o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_os_is_zyx_isa8_osv16_isv4_index(uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z,
 uint size_ifm, uint size_ofm, uint offset)
{
 const uint ifm_slices = (size_ifm + 31)/32;
 const uint isv2_idx = i % 4;
 const uint osv_idx = o % 16;
 const uint isv1_idx = (i / 4) % 8;
 const uint is_idx = i / 32;
 const uint os_idx = o / 16;
 size_t idx = offset + isv2_idx + 4 * (osv_idx + 16 * isv1_idx);
 idx += x * 4 * 8 * 16;
 idx += y * size_x * 4 * 8 * 16;
 idx += z * size_y * size_x * 4 * 8 * 16;
 idx += is_idx * size_z * size_y * size_x * 4 * 8 * 16;
 idx += os_idx * ifm_slices * size_z * size_y * size_x * 4 * 8 * 16;

 return idx;
}
#define GET_FILTER_OS_IS_ZYX_ISA8_OSV16_ISV4_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_isa8_osv16_isv4_index( o, i, z, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_os_is_yx_isa8_osv8_isv4_swizzled_by_4_index(uint o, uint i, uint y, uint x, uint size_x, uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint o_swizzled = (o % 4) * 8 + ((o % 32) / 4) + (o / 32) * 32;
 const uint f_32_aligned = ((size_ifm + 31)/32) * 32;
 const uint isv2_idx = i % 4;
 const uint osv_idx = o_swizzled % 8;
 const uint isv1_idx = (i / 4) % 8;
 const uint is_idx = i / 32;
 const uint os_idx = o_swizzled / 8;
 size_t idx = offset + isv2_idx + 4 * (osv_idx + 8 * isv1_idx);
 idx += x * 4 * 8 * 8;
 idx += y * size_x * 4 * 8 * 8;
 idx += is_idx * size_y * size_x * 4 * 8 * 8;
 idx += os_idx * (f_32_aligned/32) * size_y * size_x * 4 * 8 * 8;
 return idx;
}
inline uint get_os_is_yx_osa4_isa8_osv8_isv4_swizzled_by_4_index(uint o, uint i, uint y, uint x, uint size_x, uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint o_swizzled = (o % 4) * 8 + ((o % 32) / 4) + (o / 32) * 32;
 const uint isv_idx = i % 4;
 const uint isa_idx = (i / 4) % 8;
 const uint is_idx = (i / 32);
 const uint osv_idx = o_swizzled % 8;
 const uint osa_idx = (o_swizzled / 8) % 4;
 const uint os_idx = (o / 32);
 const uint f_32_aligned = ((size_ifm + 31)/32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 4 +
 isa_idx * 8 * 4 +
 osa_idx * 8 * 32 +
 x * 32 * 32 +
 y * size_x * 32 * 32 +
 is_idx * 32 * 32 * size_x * size_y +
 os_idx * 32 * 32 * f_32_aligned * size_x * size_y;
 return idx;
}
inline uint get_os_is_zyx_osa4_isa8_osv8_isv4_swizzled_by_4_index(uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z,
 uint size_ifm, uint size_ofm, uint offset)
{
 const uint o_swizzled = (o % 4) * 8 + ((o % 32) / 4) + (o / 32) * 32;
 const uint isv_idx = i % 4;
 const uint isa_idx = (i / 4) % 8;
 const uint is_idx = (i / 32);
 const uint osv_idx = o_swizzled % 8;
 const uint osa_idx = (o_swizzled / 8) % 4;
 const uint os_idx = (o / 32);
 const uint f_32_aligned = ((size_ifm + 31)/32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 4 +
 isa_idx * 8 * 4 +
 osa_idx * 8 * 32 +
 x * 32 * 32 +
 y * size_x * 32 * 32 +
 z * size_x * size_y * 32 * 32 +
 is_idx * 32 * 32 * size_x * size_y * size_z +
 os_idx * 32 * 32 * f_32_aligned * size_x * size_y * size_z;
 return idx;
}
inline uint get_g_is_os_yx_osa4_isa8_osv8_isv4(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv_idx = i % 4;
 const uint isa_idx = (i / 4) % 8;
 const uint is_idx = (i / 32);
 const uint osv_idx = o % 8;
 const uint osa_idx = (o / 8) % 4;
 const uint os_idx = (o / 32);
 const uint ifm_32_aligned = ((size_ifm + 31) / 32);
 const uint ofm_32_aligned = ((size_ofm + 31) / 32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 4 +
 isa_idx * 8 * 4 +
 osa_idx * 8 * 32 +
 x * 32 * 32 +
 y * size_x * 32 * 32 +
 z * size_y * size_x * 32 * 32 +
 os_idx * 32 * 32 * size_x * size_y * size_z +
 is_idx * 32 * 32 * ofm_32_aligned * size_x * size_y * size_z +
 g * 32 * 32 * ifm_32_aligned * ofm_32_aligned * size_x * size_y * size_z;
 return idx;
}
inline uint get_g_os_is_yx_osa4_isa8_osv8_isv4(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv_idx = i % 4;
 const uint isa_idx = (i / 4) % 8;
 const uint is_idx = (i / 32);
 const uint osv_idx = o % 8;
 const uint osa_idx = (o / 8) % 4;
 const uint os_idx = (o / 32);
 const uint ifm_32_aligned = ((size_ifm + 31)/32);
 const uint ofm_32_aligned = ((size_ofm + 31)/32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 4 +
 isa_idx * 8 * 4 +
 osa_idx * 8 * 32 +
 x * 32 * 32 +
 y * size_x * 32 * 32 +
 z * size_y * size_x * 32 * 32 +
 is_idx * 32 * 32 * size_x * size_y * size_z +
 os_idx * 32 * 32 * ifm_32_aligned * size_x * size_y * size_z +
 g * 32 * 32 * ifm_32_aligned * ofm_32_aligned * size_x * size_y * size_z;
 return idx;
}
inline uint get_g_os_is_yx_osa4_isa8_osv8_isv2(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv_idx = i % 2;
 const uint isa_idx = (i / 2) % 8;
 const uint is_idx = (i / 16);
 const uint osv_idx = o % 8;
 const uint osa_idx = (o / 8) % 4;
 const uint os_idx = (o / 32);
 const uint ifm_16_aligned = ((size_ifm + 15)/16);
 const uint ofm_32_aligned = ((size_ofm + 31)/32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 2 +
 isa_idx * 8 * 2 +
 osa_idx * 8 * 16 +
 x * 32 * 16 +
 y * size_x * 32 * 16 +
 z * size_y * size_x * 32 * 16 +
 is_idx * 32 * 16 * size_x * size_y * size_z +
 os_idx * 32 * 16 * ifm_16_aligned * size_x * size_y * size_z +
 g * 32 * 16 * ifm_16_aligned * ofm_32_aligned * size_x * size_y * size_z;
 return idx;
}
inline uint get_g_os_is_yx_osa2_isa8_osv8_isv2(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv_idx = i % 2;
 const uint isa_idx = (i / 2) % 8;
 const uint is_idx = (i / 16);
 const uint osv_idx = o % 8;
 const uint osa_idx = (o / 8) % 2;
 const uint os_idx = (o / 16);
 const uint ifm_16_aligned = ((size_ifm + 15)/16);
 const uint ofm_16_aligned = ((size_ofm + 15)/16);
 size_t idx = offset +
 isv_idx +
 osv_idx * 2 +
 isa_idx * 8 * 2 +
 osa_idx * 8 * 16 +
 x * 16 * 16 +
 y * size_x * 16 * 16 +
 z * size_y * size_x * 16 * 16 +
 is_idx * 16 * 16 * size_x * size_y * size_z +
 os_idx * 16 * 16 * ifm_16_aligned * size_x * size_y * size_z +
 g * 16 * 16 * ifm_16_aligned * ofm_16_aligned * size_x * size_y * size_z;
 return idx;
}
inline uint get_g_os_is_yx_osa2_isa8_osv16_isv4(uint g, uint o, uint i, uint y, uint x, uint size_x, uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv_idx = i % 4;
 const uint isa_idx = (i / 4) % 8;
 const uint is_idx = (i / 32);
 const uint osv_idx = o % 16;
 const uint osa_idx = (o / 16) % 2;
 const uint os_idx = (o / 32);
 const uint ifm_32_aligned = ((size_ifm + 31)/32);
 const uint ofm_32_aligned = ((size_ofm + 31)/32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 4 +
 isa_idx * 16 * 4 +
 osa_idx * 8 * 64 +
 x * 32 * 32 +
 y * size_x * 32 * 32 +
 is_idx * 32 * 32 * size_x * size_y +
 os_idx * 32 * 32 * ifm_32_aligned * size_x * size_y +
 g * 32 * 32 * ifm_32_aligned * ofm_32_aligned * size_x * size_y;
 return idx;
}
inline uint get_g_os_is_yx_osa2_isa8_osv16_isv2(uint g, uint o, uint i, uint y, uint x, uint size_x, uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint isv_idx = i % 2;
 const uint isa_idx = (i / 2) % 8;
 const uint is_idx = (i / 16);
 const uint osv_idx = o % 16;
 const uint osa_idx = (o / 16) % 2;
 const uint os_idx = (o / 32);
 const uint ifm_16_aligned = ((size_ifm + 15)/16);
 const uint ofm_32_aligned = ((size_ofm + 31)/32);
 size_t idx = offset +
 isv_idx +
 osv_idx * 2 +
 isa_idx * 16 * 2 +
 osa_idx * 8 * 32 +
 x * 32 * 16 +
 y * size_x * 32 * 16 +
 is_idx * 32 * 16 * size_x * size_y +
 os_idx * 32 * 16 * ifm_16_aligned * size_x * size_y +
 g * 32 * 16 * ifm_16_aligned * ofm_32_aligned * size_x * size_y;
 return idx;
}
inline uint get_g_is_os_yx_isa2_osa8_isv8_osv2(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 return get_g_os_is_yx_osa2_isa8_osv8_isv2(g, i, o, z, y, x, size_x, size_y, size_z, size_ofm, size_ifm, offset);
}
inline uint get_g_is_os_yx_isa4_osa8_isv8_osv4(uint g, uint o, uint i, uint z, uint y, uint x,
 uint size_x, uint size_y, uint size_z, uint size_ifm, uint size_ofm, uint offset)
{
 return get_g_os_is_yx_osa4_isa8_osv8_isv4(g, i, o, z, y, x, size_x, size_y, size_z, size_ofm, size_ifm, offset);
}
#define GET_FILTER_IS_OS_YX_OSA4_ISA8_OSV8_ISV4_INDEX(prefix, o, i, y, x) get_g_is_os_yx_osa4_isa8_osv8_isv4( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_OSA4_ISA8_OSV8_ISV4_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv4( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_ZYX_OSA4_ISA8_OSV8_ISV4_INDEX(prefix, o, i, z, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv4( 0, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_YX_OSA4_ISA8_OSV8_ISV4_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv4( g, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_ZYX_OSA4_ISA8_OSV8_ISV4_INDEX(prefix, g, o, i, z, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv4( g, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_OSA4_ISA8_OSV8_ISV2_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv2( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_ZYX_OSA4_ISA8_OSV8_ISV2_INDEX(prefix, o, i, z, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv2( 0, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_YX_OSA4_ISA8_OSV8_ISV2_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv2( g, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_ZYX_OSA4_ISA8_OSV8_ISV2_INDEX(prefix, g, o, i, z, y, x) get_g_os_is_yx_osa4_isa8_osv8_isv2( g, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_YX_OSA2_ISA8_OSV8_ISV2_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osa2_isa8_osv8_isv2( g, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_OSA2_ISA8_OSV8_ISV2_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osa2_isa8_osv8_isv2( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_ZYX_OSA2_ISA8_OSV8_ISV2_INDEX(prefix, o, i, z, y, x) get_g_os_is_yx_osa2_isa8_osv8_isv2( 0, o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_OSA2_ISA8_OSV16_ISV4_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osa2_isa8_osv16_isv4( 0, o, i, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_YX_OSA2_ISA8_OSV16_ISV4_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osa2_isa8_osv16_isv4( g, o, i, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))

#define GET_FILTER_OS_IS_YX_OSA2_ISA8_OSV16_ISV2_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osa2_isa8_osv16_isv2( 0, o, i, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_G_OS_IS_YX_OSA2_ISA8_OSV16_ISV2_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osa2_isa8_osv16_isv2( g, o, i, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_ISA8_OSV8_ISV4_SWIZZLED_BY_4_INDEX(prefix, o, i, y, x) get_os_is_yx_isa8_osv8_isv4_swizzled_by_4_index( o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_YX_OSA4_ISA8_OSV8_ISV4_SWIZZLED_BY_4_INDEX(prefix, o, i, y, x) get_os_is_yx_osa4_isa8_osv8_isv4_swizzled_by_4_index( o, i, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_OS_IS_ZYX_OSA4_ISA8_OSV8_ISV4_SWIZZLED_BY_4_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osa4_isa8_osv8_isv4_swizzled_by_4_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_IS_OS_YX_ISA2_OSA8_ISV8_OSV2_INDEX(prefix, o, i, y, x) get_g_is_os_yx_isa2_osa8_isv8_osv2( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
#define GET_FILTER_IS_OS_YX_ISA4_OSA8_ISV8_OSV4_INDEX(prefix, o, i, y, x) get_g_is_os_yx_isa4_osa8_isv8_osv4( 0, o, i, 0, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 1, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_is_o_yx_isv32_index(uint o, uint i, uint y, uint x, uint i_size, uint o_size, uint x_size, uint y_size)
{
 const uint i_aligned_to_32 = ((i_size + 31) / 32) * 32;
 const uint i_val = i % 32;
 const uint i_slice = i / 32;
 const size_t idx = i_val + 32* (x + x_size * (y + y_size * (o + o_size * i_slice) ) );
 return idx;
}
#define GET_FILTER_IS_O_YX_ISV32(prefix, o, i, y, x) get_is_o_yx_isv32_index( o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y))
inline uint get_is_o32_yx_isv32_swizzled_by_4_index(uint o, uint i, uint y, uint x, uint i_size, uint o_size, uint x_size, uint y_size)
{
 const uint o_aligned_to_32 = ((o_size + 31) / 32) * 32;
 const uint o_swizzled = (o % 4) * 8 + ((o % 32) / 4) + (o / 32) * 32;
 const uint i_aligned_to_32 = ((i_size + 31) / 32) * 32;
 const uint i_val = i % 32;
 const uint i_slice = i / 32;
 const size_t idx = i_val + 32* (x + x_size * (y + y_size * (o_swizzled + o_aligned_to_32 * i_slice) ) );
 return idx;
}
#define GET_FILTER_IS_O32_YX_ISV32_SWIZZLED_BY_4(prefix, o, i, y, x) get_is_o32_yx_isv32_swizzled_by_4_index( o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y))
inline uint get_os_is_y_x8_osv8_isv4_index(uint o, uint i, uint y, uint x, uint i_size, uint o_size, uint x_size, uint y_size)
{
 const uint i_aligned_to_4 = ((i_size + 3) / 4) * 4;
 const uint o_aligned_to_8 = ((o_size + 7) / 8) * 8;
 const uint x_aligned_to_8 = ((x_size + 7) / 8) * 8;
 const uint i_val = i % 4;
 const uint i_slice = i / 4;
 const uint o_val = o % 8;
 const uint o_slice = o / 8;
 const size_t idx = i_val + 4 * (o_val + 8 * ( x + x_aligned_to_8 * (y + y_size * (i_slice + (i_aligned_to_4/4) * (o_slice)))));
 return idx;
}
#define GET_FILTER_OS_IS_Y_X8_OSV8_ISV4(prefix, o, i, y, x) get_os_is_y_x8_osv8_isv4_index( o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y))
inline uint get_os_is_y_x8_osv8_isv4_swizzled_by_4_index(uint o, uint i, uint y, uint x, uint i_size, uint o_size, uint x_size, uint y_size)
{
 const uint i_aligned_to_4 = ((i_size + 3) / 4) * 4;
 const uint o_aligned_to_8 = ((o_size + 7) / 8) * 8;
 const uint x_aligned_to_8 = ((x_size + 7) / 8) * 8;
 const uint i_val = i % 4;
 const uint i_slice = i / 4;
 const uint o_swizzled = (o % 4) * 8 + ((o % 32) / 4) + (o / 32) * 32;
 const uint o_val = o_swizzled % 8;
 const uint o_slice = o_swizzled / 8;
 const size_t idx = i_val + 4 * (o_val + 8 * ( x + x_aligned_to_8 * (y + y_size * (i_slice + (i_aligned_to_4/4) * (o_slice)))));
 return idx;
}
#define GET_FILTER_OS_IS_Y_X8_OSV8_ISV4_SWIZZLED_BY_4(prefix, o, i, y, x) get_os_is_y_x8_osv8_isv4_swizzled_by_4_index( o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y))
#define GET_FILTER_G_OS_IS_YX_OSV8_ISV2_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osv_isv( g, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 8, 2)
#define GET_FILTER_G_OS_IS_YX_OSV8_ISV4_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osv_isv( g, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 8, 4)
#define GET_FILTER_G_OS_IS_YX_OSV16_ISV4_INDEX(prefix, g, o, i, y, x) get_g_os_is_yx_osv_isv( g, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 16, 4)
inline uint get_g_os_is_yx_osv_isv(uint g, uint o, uint i, uint y, uint x,
 uint i_size,
 uint o_size,
 uint x_size,
 uint y_size,
 uint osv_size,
 uint isv_size)
{
 return get_g_os_is_zyx_osv_isv_index(g, o, i, 0, y, x,
 x_size, y_size, 1, i_size, o_size, osv_size, isv_size);
}
#define GET_FILTER_OS_IS_YX_OSV8_ISV2_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osv_isv( 0, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 8, 2)
#define GET_FILTER_OS_IS_ZYX_OSV8_ISV2_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osv_isv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 8, 2)
#define GET_FILTER_OS_IS_YX_OSV8_ISV4_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osv_isv( 0, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 8, 4)
#define GET_FILTER_OS_IS_ZYX_OSV8_ISV4_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osv_isv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 8, 4)
#define GET_FILTER_OS_IS_YX_OSV16_ISV4_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osv_isv( 0, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 16, 4)
#define GET_FILTER_OS_IS_YX_OSV32_ISV4_INDEX(prefix, o, i, y, x) get_g_os_is_yx_osv_isv( 0, o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 32, 4)
#define GET_FILTER_OS_IS_ZYX_OSV32_ISV4_INDEX(prefix, o, i, z, y, x) get_os_is_zyx_osv_isv_index( o, i, z, y, x, CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_Z), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), 32, 4)
#define GET_FILTER_OS_IS_YX_OSV32_ISV4_SWIZZLED_BY_2_INDEX(prefix, o, i, y, x) get_os_is_yx_osv32_isv4_swizzled_by_2( o, i, y, x, CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _SIZE_Y), CAT(prefix, _SIZE_X))
inline uint get_os_is_yx_osv32_isv4_swizzled_by_2(uint o, uint i, uint y, uint x,
 uint o_size,
 uint i_size,
 uint y_size,
 uint x_size)
{
 const uint osv = 32;
 const uint os = o / osv;
 const uint ofm_block = (o % osv) % 2;
 const uint ofm_in_block = (o % osv) / 2;
 const uint tile = 4;
 const uint ifm_aligned = ((i_size + tile - 1) / tile) * tile;
 const uint ifm_tile = i / tile;
 const uint id = i - ifm_tile * tile;
 uint idx = os * ifm_aligned * y_size * x_size * osv
 + ifm_tile * y_size * x_size * osv * tile
 + y * x_size * osv * tile
 + x * osv * tile
 + ofm_block * 16 * tile
 + ofm_in_block * tile
 + id;
 return idx;
}
inline uint get_os_is_osv32_isv32_swizzled_by_4_index(uint o, uint i, uint y, uint x, uint size_x, uint size_y, uint size_ifm, uint size_ofm, uint offset)
{
 const uint size_ifm_a = ((size_ifm + 31)/32) * 32;
 const uint o_hi = o / 32;
 const uint o_lo = o % 32;
 const uint i_hi = i / 32;
 const uint i_lo = i % 32;
 const uint o_lo1 = o_lo % 4;
 const uint o_lo2 = (o_lo / 4) % 8;
 const uint i_lo1 = i_lo % 4;
 const uint i_lo2 = i_lo / 4;
 const uint idx_in_group = o_lo2 * 4 + o_lo1 * (32 * 8) + i_lo2 * 32 + i_lo1;
 const uint group_idx = o_hi * (size_ifm_a / 32) + i_hi;
 return group_idx * (32 * 32) + idx_in_group;
}
#define GET_FILTER_OS_IS_OSV32_ISV32_SWIZZLED_BY_4_INDEX(prefix, o, i, y, x) get_os_is_osv32_isv32_swizzled_by_4_index( o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _SIZE_Y), CAT(prefix, _IFM_NUM), CAT(prefix, _OFM_NUM), CAT(prefix, _OFFSET))
inline uint get_os_i_yxs_osv_yxsv4_index(uint o, uint i, uint y, uint x, uint i_size, uint size_x, uint size_y, uint osv) {
 const uint yxsv = 4;
 uint yx = y * size_x + x;
 uint yx_size_aligned = (size_x * size_y + yxsv - 1) / yxsv * yxsv;
 uint os_index = o / osv;
 uint yxs_index = yx / yxsv;
 uint osv_index = o % osv;
 uint yxsv_index = yx % yxsv;
 uint index = 0;
 index += yxsv_index;
 index += osv_index * yxsv;
 index += yxs_index * yxsv * osv;
 index += i * osv * yx_size_aligned;
 index += os_index * osv * yx_size_aligned * i_size;
 return index;
}
#define GET_FILTER_OS_I_YXS_OSV4_YXSV4_INDEX(prefix, o, i, y, x) get_os_i_yxs_osv_yxsv4_index( o, i, y, x, CAT(prefix, _IFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 4)
#define GET_FILTER_G_OS_IYX_OSV16(prefix, g, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + (g * CAT(prefix, _GROUPS_PITCH)) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + ((o) / (sub_group_size))*CAT(prefix, _OFM_PITCH) )
#define GET_FILTER_OS_IYX_OSV16(prefix, o, i, y, x, sub_group_size) GET_FILTER_G_OS_IYX_OSV16(prefix, 0, o, i, y, x, sub_group_size)
#define GET_FILTER_GS_OIYX_GSV16(prefix, g, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((g) % (sub_group_size)) + (sub_group_size)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + (o)*CAT(prefix, _OFM_PITCH) + ((g) / (sub_group_size))*CAT(prefix, _GROUPS_PITCH) )
#define GET_FILTER_GS_OIZYX_GSV16(prefix, g, o, i, z, y, x, sub_group_size) CAT(prefix, _OFFSET) + ((g) % (sub_group_size)) + (sub_group_size)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (z)*CAT(prefix, _Z_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + (o)*CAT(prefix, _OFM_PITCH) + ((g) / (sub_group_size))*CAT(prefix, _GROUPS_PITCH) )
#define GET_FILTER_G_OS_IYX_OSV16_ROTATE_180(prefix, g, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + (g * CAT(prefix, _GROUPS_PITCH)) + ((o) % (sub_group_size)) + (sub_group_size)*( (CAT(prefix, _SIZE_X ) - x - 1)*CAT(prefix, _X_PITCH) + (CAT(prefix, _SIZE_Y ) - y - 1)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + ((o) / (sub_group_size))*CAT(prefix, _OFM_PITCH) )
#define GET_FILTER_G_IS_OS_ZYX_ISV16_OSV16_INDEX(prefix, g, o, i, z, y, x, sub_group_size) CAT(prefix, _OFFSET) + (g)*CAT(prefix, _GROUPS_PITCH) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + (z)*(sub_group_size)*CAT(prefix, _Z_PITCH) + ((i) % (sub_group_size)) + ((o) / (sub_group_size))*(sub_group_size)*CAT(prefix, _OFM_PITCH) + ((i) / (sub_group_size))*CAT(prefix, _IFM_PITCH) )
#define GET_FILTER_G_IS_OS_YX_ISV16_OSV16_INDEX(prefix, g, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + (g)*CAT(prefix, _GROUPS_PITCH) + ((o) % (sub_group_size)) +  (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + ((i) % (sub_group_size)) + ((o) / (sub_group_size))*(sub_group_size)*CAT(prefix, _OFM_PITCH) + ((i) / (sub_group_size))*CAT(prefix, _IFM_PITCH) )
#define GET_FILTER_G_OS_IS_ZYX_ISV16_OSV16_INDEX(prefix, g, o, i, z, y, x, sub_group_size) CAT(prefix, _OFFSET) + (g)*CAT(prefix, _GROUPS_PITCH) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + (z)*(sub_group_size)*CAT(prefix, _Z_PITCH) + ((i) % (sub_group_size)) + ((i) / (sub_group_size))*(sub_group_size)*CAT(prefix, _IFM_PITCH) + ((o) / (sub_group_size))*CAT(prefix, _OFM_PITCH) )
#define GET_FILTER_GI_YXS_OS_YXSV2_OSV_INDEX(prefix, g, o, i, y, x, sub_group_size) get_gi_yxs_os_yxsv2_osv_index( g, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _GROUPS_PITCH), CAT(prefix, _IFM_PITCH), CAT(prefix, _Y_PITCH), CAT(prefix, _X_PITCH), CAT(prefix, _OFFSET), sub_group_size)
#define GET_FILTER_GIY_XS_OS_XSV2_OSV_INDEX(prefix, g, o, i, y, x, sub_group_size) get_giy_xs_os_xsv2_osv_index( g, o, i, y, x, CAT(prefix, _SIZE_X ), CAT(prefix, _GROUPS_PITCH), CAT(prefix, _IFM_PITCH), CAT(prefix, _Y_PITCH), CAT(prefix, _X_PITCH), CAT(prefix, _OFFSET), sub_group_size)
inline uint get_gs_oi_yxs_gsv_yxsv4_index(uint g, uint o, uint i, uint y, uint x, uint o_size, uint i_size, uint size_x, uint size_y, const uint gsv) {
 const uint yxsv = 4;
 uint yx = y * size_x + x;
 uint yx_size_aligned = (size_x * size_y + yxsv - 1) / yxsv * yxsv;
 uint gs_index = g / gsv;
 uint yxs_index = yx / yxsv;
 uint gsv_index = g % gsv;
 uint yxsv_index = yx % yxsv;
 uint index = 0;
 index += yxsv_index;
 index += gsv_index * yxsv;
 index += yxs_index * yxsv * gsv;
 index += o * i * gsv * yx_size_aligned;
 index += gs_index * gsv * yx_size_aligned * o_size * i_size;
 return index;
}
#define GET_FILTER_GS_OI_YXS_GSV4_YXSV4_INDEX(prefix, g, o, i, y, x) get_gs_oi_yxs_gsv_yxsv4_index( g, o, i, y, x, CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 4)
#define GET_FILTER_GS_OI_YXS_GSV16_YXSV4_INDEX(prefix, g, o, i, y, x) get_gs_oi_yxs_gsv_yxsv4_index( g, o, i, y, x, CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 16)
#define GET_FILTER_GS_OI_YXS_GSV32_YXSV4_INDEX(prefix, g, o, i, y, x) get_gs_oi_yxs_gsv_yxsv4_index( g, o, i, y, x, CAT(prefix, _OFM_NUM), CAT(prefix, _IFM_NUM), CAT(prefix, _SIZE_X), CAT(prefix, _SIZE_Y), 32)
#define GET_FILTER_G_OS_IS_YX_ISV16_OSV16_INDEX(prefix, g, o, i, y, x, sub_group_size) CAT(prefix, _OFFSET) + (g * CAT(prefix, _GROUPS_PITCH)) + ((o) % (sub_group_size)) + (sub_group_size)*( (x)*(sub_group_size)*CAT(prefix, _X_PITCH) + (y)*(sub_group_size)*CAT(prefix, _Y_PITCH) + ((i) % (sub_group_size)) + ((i) / (sub_group_size))*(sub_group_size)*CAT(prefix, _IFM_PITCH) + ((o) / (sub_group_size))*CAT(prefix, _OFM_PITCH) )
inline uint get_g_os_zyx_is_osv_isv_index(uint g, uint o, uint i, uint z, uint y, uint x,
 uint g_size, uint o_size, uint i_size, uint z_size, uint y_size, uint x_size,
 uint osv, uint isv) {
 uint is_size = (i_size + isv - 1) / isv;
 uint os_size = (o_size + osv - 1) / osv;
 uint isv_index = i % isv;
 uint osv_index = o % osv;
 uint is_index = i / isv;
 uint os_index = o / osv;
 uint isv_pitch = 1;
 uint osv_pitch = isv_pitch * isv;
 uint is_pitch = osv_pitch * osv;
 uint x_pitch = is_pitch * is_size;
 uint y_pitch = x_pitch * x_size;
 uint z_pitch = y_pitch * y_size;
 uint os_pitch = z_pitch * z_size;
 uint g_pitch = os_pitch * os_size;
 uint index = 0;
 index += isv_index * isv_pitch;
 index += osv_index * osv_pitch;
 index += is_index * is_pitch;
 index += x * x_pitch;
 index += y * y_pitch;
 index += z * z_pitch;
 index += os_index * os_pitch;
 index += g * g_pitch;
 return index;
}
#define GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, osv, isv) get_g_os_zyx_is_osv_isv_index( g, o, i, z, y, x, CAT(tensor, _GROUPS_NUM), CAT(tensor, _OFM_NUM), CAT(tensor, _IFM_NUM), CAT(tensor, _SIZE_Z), CAT(tensor, _SIZE_Y), CAT(tensor, _SIZE_X), osv, isv)
#define GET_FILTER_OS_YX_IS_OSV8_ISV2_INDEX(tensor, o, i, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, 0, o, i, 0, y, x, 8, 2)
#define GET_FILTER_OS_YX_IS_OSV8_ISV4_INDEX(tensor, o, i, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, 0, o, i, 0, y, x, 8, 4)
#define GET_FILTER_OS_ZYX_IS_OSV8_ISV2_INDEX(tensor, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, 0, o, i, z, y, x, 8, 2)
#define GET_FILTER_OS_ZYX_IS_OSV8_ISV4_INDEX(tensor, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, 0, o, i, z, y, x, 8, 4)
#define GET_FILTER_G_OS_YX_IS_OSV8_ISV2_INDEX(tensor, g, o, i, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 8, 2)
#define GET_FILTER_G_OS_YX_IS_OSV8_ISV4_INDEX(tensor, g, o, i, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 8, 4)
#define GET_FILTER_G_OS_ZYX_IS_OSV8_ISV2_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 8, 2)
#define GET_FILTER_G_OS_ZYX_IS_OSV8_ISV4_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 8, 4)
#define GET_FILTER_G_OS_ZYX_IS_OSV16_ISV4_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 16, 4)
#define GET_FILTER_G_OS_ZYX_IS_OSV16_ISV16_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 16, 16)
#define GET_FILTER_G_OS_ZYX_IS_OSV16_ISV32_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 16, 32)
#define GET_FILTER_G_OS_ZYX_IS_OSV32_ISV4_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 32, 4)
#define GET_FILTER_G_OS_ZYX_IS_OSV32_ISV16_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 32, 16)
#define GET_FILTER_G_OS_ZYX_IS_OSV32_ISV32_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZYX_IS_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 32, 32)
#define GET_FILTER_O_IS_YX_ISV16_INDEX(prefix, o, i, y, x, isv) CAT(prefix, _OFFSET) + ((i) % (isv)) + (o)*CAT(prefix, _OFM_PITCH) + (isv)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + ((i) / (isv))*CAT(prefix, _IFM_PITCH) )
#define GET_FILTER_OS_YXI_OSV16(prefix, o, i, y, x) CAT(prefix, _OFFSET) + ((o) % (16)) + (16)*( (x)*CAT(prefix, _X_PITCH) + (y)*CAT(prefix, _Y_PITCH) + (i)*CAT(prefix, _IFM_PITCH) + ((o) / (16))*CAT(prefix, _OFM_PITCH) )
inline uint get_g_os_y_is_x_osv_isv_index(uint g, uint o, uint i, uint y, uint x,
 uint x_size, uint y_size, uint i_size, uint o_size, uint osv_size, uint isv_size)
{
 const uint isv = i % isv_size;
 const uint osv = o % osv_size;
 const uint is = i / isv_size;
 const uint os = o / osv_size;
 const uint x_pitch = osv_size * isv_size;
 const uint is_pitch = x_pitch * x_size;
 const uint y_pitch = is_pitch * ((i_size + isv_size - 1) / isv_size);
 const uint os_pitch = y_pitch * y_size;
 const uint g_pitch = os_pitch * ((o_size + osv_size - 1) / osv_size);
 const uint output_offset =
 isv +
 osv * isv_size +
 x * x_pitch +
 is * is_pitch +
 y * y_pitch +
 os * os_pitch +
 g * g_pitch;
 return output_offset;
}
#define GET_FILTER_G_OS_Y_IS_X_OSV_ISV_INDEX(tensor, g, o, i, y, x, osv, isv) get_g_os_y_is_x_osv_isv_index( g, o, i, y, x, CAT(tensor, _SIZE_X), CAT(tensor, _SIZE_Y), CAT(tensor, _IFM_NUM), CAT(tensor, _OFM_NUM), osv, isv)
#define GET_FILTER_OS_Y_IS_X_OSV8_ISV2_INDEX(tensor, o, i, y, x) GET_FILTER_G_OS_Y_IS_X_OSV_ISV_INDEX(tensor, 0, o, i, y, x, 8, 2)
#define GET_FILTER_OS_Y_IS_X_OSV8_ISV4_INDEX(tensor, o, i, y, x) GET_FILTER_G_OS_Y_IS_X_OSV_ISV_INDEX(tensor, 0, o, i, y, x, 8, 4)
#define GET_FILTER_G_OS_Y_IS_X_OSV8_ISV2_INDEX(tensor, g, o, i, y, x) GET_FILTER_G_OS_Y_IS_X_OSV_ISV_INDEX(tensor, g, o, i, y, x, 8, 2)
#define GET_FILTER_G_OS_Y_IS_X_OSV8_ISV4_INDEX(tensor, g, o, i, y, x) GET_FILTER_G_OS_Y_IS_X_OSV_ISV_INDEX(tensor, g, o, i, y, x, 8, 4)
inline uint get_g_os_zy_is_x_osv_isv_index(uint g, uint o, uint i, uint z, uint y, uint x,
 uint o_size, uint i_size, uint z_size, uint y_size, uint x_size,
 uint osv, uint isv) {
 uint is_size = (i_size + isv - 1) / isv;
 uint os_size = (o_size + osv - 1) / osv;
 uint isv_index = i % isv;
 uint osv_index = o % osv;
 uint is_index = i / isv;
 uint os_index = o / osv;
 uint isv_pitch = 1;
 uint osv_pitch = isv_pitch * isv;
 uint x_pitch = osv_pitch * osv;
 uint is_pitch = x_pitch * x_size;
 uint y_pitch = is_pitch * is_size;
 uint z_pitch = y_pitch * y_size;
 uint os_pitch = z_pitch * z_size;
 uint g_pitch = os_pitch * os_size;
 uint index = 0;
 index += isv_index * isv_pitch;
 index += osv_index * osv_pitch;
 index += is_index * is_pitch;
 index += x * x_pitch;
 index += y * y_pitch;
 index += z * z_pitch;
 index += os_index * os_pitch;
 index += g * g_pitch;
 return index;
}
#define GET_FILTER_G_OS_ZY_IS_X_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, osv, isv) get_g_os_zy_is_x_osv_isv_index( g, o, i, z, y, x, CAT(tensor, _OFM_NUM), CAT(tensor, _IFM_NUM), CAT(tensor, _SIZE_Z), CAT(tensor, _SIZE_Y), CAT(tensor, _SIZE_X), osv, isv)
#define GET_FILTER_OS_ZY_IS_X_OSV8_ISV2_INDEX(tensor, o, i, z, y, x) GET_FILTER_G_OS_ZY_IS_X_OSV_ISV_INDEX(tensor, 0, o, i, z, y, x, 8, 2)
#define GET_FILTER_OS_ZY_IS_X_OSV8_ISV4_INDEX(tensor, o, i, z, y, x) GET_FILTER_G_OS_ZY_IS_X_OSV_ISV_INDEX(tensor, 0, o, i, z, y, x, 8, 4)
#define GET_FILTER_G_OS_ZY_IS_X_OSV8_ISV2_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZY_IS_X_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 8, 2)
#define GET_FILTER_G_OS_ZY_IS_X_OSV8_ISV4_INDEX(tensor, g, o, i, z, y, x) GET_FILTER_G_OS_ZY_IS_X_OSV_ISV_INDEX(tensor, g, o, i, z, y, x, 8, 4)

#define BLOCK_WRITE_TYPE_size1 uchar
#define BLOCK_WRITE_TYPE_size2 ushort
#define BLOCK_WRITE_TYPE_size4 uint
#define BLOCK_WRITE_TYPE_size8 ulong
#define BLOCK_WRITE_TYPE(type_size) CAT(BLOCK_WRITE_TYPE_size, type_size)
#define BLOCK_WRITE_FUNC_size1 _sub_group_block_write_uc
#define BLOCK_WRITE_FUNC_size2 _sub_group_block_write_us
#define BLOCK_WRITE_FUNC_size4 _sub_group_block_write
#define BLOCK_WRITE_FUNC_size8 _sub_group_block_write_ul
#define BLOCK_WRITE_FUNC(type_size) CAT(BLOCK_WRITE_FUNC_size, type_size)
#define BLOCK_WRITEN_FUNC_SIZE_DEF(type_size, vector_size) MAKE_VECTOR_TYPE(BLOCK_WRITE_FUNC(type_size), vector_size)
#define BLOCK_WRITEN_FUNC_size1(vector_size) BLOCK_WRITEN_FUNC_SIZE_DEF(1, vector_size)
#define BLOCK_WRITEN_FUNC_size2(vector_size) BLOCK_WRITEN_FUNC_SIZE_DEF(2, vector_size)
#define BLOCK_WRITEN_FUNC_size4(vector_size) BLOCK_WRITEN_FUNC_SIZE_DEF(4, vector_size)
#define BLOCK_WRITEN_FUNC_size8(vector_size) BLOCK_WRITEN_FUNC_SIZE_DEF(8, vector_size)
#define BLOCK_WRITEN_FUNC(type_size, vector_size) CAT(BLOCK_WRITEN_FUNC_size, type_size)(vector_size)
#define BLOCK_WRITEN_RAW(type_size, vector_size, addr_space, ptr, offset, val) BLOCK_WRITEN_FUNC(type_size, vector_size)( (addr_space BLOCK_WRITE_TYPE(type_size)*)(ptr) + (offset), AS_TYPE(MAKE_VECTOR_TYPE(BLOCK_WRITE_TYPE(type_size), vector_size), val))
#define BLOCK_WRITEN(type, vector_size, ptr, offset, val) BLOCK_WRITEN_RAW(TYPE_SIZE(type), vector_size, __global, ptr, offset, val)
#define BLOCK_WRITEN_SLM(type, vector_size, ptr, offset, val) BLOCK_WRITEN_RAW(TYPE_SIZE(type), vector_size, __local, ptr, offset, val)
#define DT_OUTPUT_BLOCK_WRITE(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, 1, ptr, offset, val)
#define DT_OUTPUT_BLOCK_WRITE2(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, 2, ptr, offset, val)
#define DT_OUTPUT_BLOCK_WRITE4(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, 4, ptr, offset, val)
#define DT_OUTPUT_BLOCK_WRITE8(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, 8, ptr, offset, val)
#define DT_OUTPUT_BLOCK_WRITE16(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, 16, ptr, offset, val)
#define BLOCK_WRITE_IMPL_1 out_ptr[idx] = v;
#define BLOCK_WRITE_IMPL_2 out_ptr[idx] = v.s0; idx += get_max_sub_group_size(); out_ptr[idx] = v.s1; idx += get_max_sub_group_size();
#define BLOCK_WRITE_IMPL_4 BLOCK_WRITE_IMPL_2 out_ptr[idx] = v.s2; idx += get_max_sub_group_size(); out_ptr[idx] = v.s3; idx += get_max_sub_group_size();
#define BLOCK_WRITE_IMPL_8 BLOCK_WRITE_IMPL_4 out_ptr[idx] = v.s4; idx += get_max_sub_group_size(); out_ptr[idx] = v.s5; idx += get_max_sub_group_size(); out_ptr[idx] = v.s6; idx += get_max_sub_group_size(); out_ptr[idx] = v.s7; idx += get_max_sub_group_size();
#define BLOCK_WRITE_IMPL_16 BLOCK_WRITE_IMPL_8 out_ptr[idx] = v.s8; idx += get_max_sub_group_size(); out_ptr[idx] = v.s9; idx += get_max_sub_group_size(); out_ptr[idx] = v.sa; idx += get_max_sub_group_size(); out_ptr[idx] = v.sb; idx += get_max_sub_group_size(); out_ptr[idx] = v.sc; idx += get_max_sub_group_size(); out_ptr[idx] = v.sd; idx += get_max_sub_group_size(); out_ptr[idx] = v.se; idx += get_max_sub_group_size(); out_ptr[idx] = v.sf; idx += get_max_sub_group_size();
#define BLOCK_WRITE_IMPL(vec_size) CAT(BLOCK_WRITE_IMPL_, vec_size)
#define BLOCK_WRITE_FUNC_NAME(type_size, vec_size) MAKE_VECTOR_TYPE(BLOCK_WRITE_FUNC(type_size), vec_size)
#define DECLARE_BLOCK_WRITE_EMULATION(type_size, vec_size) inline void BLOCK_WRITE_FUNC_NAME(type_size, vec_size)(__global BLOCK_WRITE_TYPE(type_size)* out_ptr, MAKE_VECTOR_TYPE(BLOCK_WRITE_TYPE(type_size), vec_size) v) { uint idx = get_sub_group_local_id(); BLOCK_WRITE_IMPL(vec_size) }
#if defined(cl_intel_subgroups)
 #define _sub_group_block_write(ptr, v) intel_sub_group_block_write(ptr, v)
 #define _sub_group_block_write2(ptr, v) intel_sub_group_block_write2(ptr, v)
 #define _sub_group_block_write4(ptr, v) intel_sub_group_block_write4(ptr, v)
 #define _sub_group_block_write8(ptr, v) intel_sub_group_block_write8(ptr, v)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_WRITE_EMULATION(4, 1)
 DECLARE_BLOCK_WRITE_EMULATION(4, 2)
 DECLARE_BLOCK_WRITE_EMULATION(4, 4)
 DECLARE_BLOCK_WRITE_EMULATION(4, 8)
#endif
#if defined(cl_intel_subgroups_short)
 #define _sub_group_block_write_us(ptr, v) intel_sub_group_block_write_us(ptr, v)
 #define _sub_group_block_write_us2(ptr, v) intel_sub_group_block_write_us2(ptr, v)
 #define _sub_group_block_write_us4(ptr, v) intel_sub_group_block_write_us4(ptr, v)
 #define _sub_group_block_write_us8(ptr, v) intel_sub_group_block_write_us8(ptr, v)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_WRITE_EMULATION(2, 1)
 DECLARE_BLOCK_WRITE_EMULATION(2, 2)
 DECLARE_BLOCK_WRITE_EMULATION(2, 4)
 DECLARE_BLOCK_WRITE_EMULATION(2, 8)
#endif
#if defined(cl_intel_subgroups_char)
 #define _sub_group_block_write_uc(ptr, v) intel_sub_group_block_write_uc(ptr, v)
 #define _sub_group_block_write_uc2(ptr, v) intel_sub_group_block_write_uc2(ptr, v)
 #define _sub_group_block_write_uc4(ptr, v) intel_sub_group_block_write_uc4(ptr, v)
 #define _sub_group_block_write_uc8(ptr, v) intel_sub_group_block_write_uc8(ptr, v)
 #define _sub_group_block_write_uc16(ptr, v) intel_sub_group_block_write_uc16(ptr, v)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_WRITE_EMULATION(1, 1)
 DECLARE_BLOCK_WRITE_EMULATION(1, 2)
 DECLARE_BLOCK_WRITE_EMULATION(1, 4)
 DECLARE_BLOCK_WRITE_EMULATION(1, 8)
 DECLARE_BLOCK_WRITE_EMULATION(1, 16)
#endif
#if defined(cl_intel_subgroups_long)
 #define _sub_group_block_write_ul(ptr, v) intel_sub_group_block_write_ul(ptr, v)
 #define _sub_group_block_write_ul2(ptr, v) intel_sub_group_block_write_ul2(ptr, v)
 #define _sub_group_block_write_ul4(ptr, v) intel_sub_group_block_write_ul4(ptr, v)
 #define _sub_group_block_write_ul8(ptr, v) intel_sub_group_block_write_ul8(ptr, v)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_WRITE_EMULATION(8, 1)
 DECLARE_BLOCK_WRITE_EMULATION(8, 2)
 DECLARE_BLOCK_WRITE_EMULATION(8, 4)
 DECLARE_BLOCK_WRITE_EMULATION(8, 8)
#endif

inline int imad_SW(int acc, uchar4 input, char4 weight) __attribute__((overloadable)) {
 acc += input[0] * weight[0];
 acc += input[1] * weight[1];
 acc += input[2] * weight[2];
 acc += input[3] * weight[3];
 return acc;
}
inline int imad_SW(int acc, char4 input, char4 weight) __attribute__((overloadable)) {
 acc += input[0] * weight[0];
 acc += input[1] * weight[1];
 acc += input[2] * weight[2];
 acc += input[3] * weight[3];
 return acc;
}
inline int imad_SW(int acc, char4 input, uchar4 weight) __attribute__((overloadable)) {
 acc += input[0] * weight[0];
 acc += input[1] * weight[1];
 acc += input[2] * weight[2];
 acc += input[3] * weight[3];
 return acc;
}
inline int imad_SW(int acc, uchar4 input, uchar4 weight) __attribute__((overloadable)) {
 acc += input[0] * weight[0];
 acc += input[1] * weight[1];
 acc += input[2] * weight[2];
 acc += input[3] * weight[3];
 return acc;
}
#define IMAD(_O, _I, _W) imad_SW(_O, _I, _W)

#define BLOCK_READ_TYPE_size1 uchar
#define BLOCK_READ_TYPE_size2 ushort
#define BLOCK_READ_TYPE_size4 uint
#define BLOCK_READ_TYPE_size8 ulong
#define BLOCK_READ_TYPE(type_size) CAT(BLOCK_READ_TYPE_size, type_size)
#define BLOCK_READ_FUNC_size1 _sub_group_block_read_uc
#define BLOCK_READ_FUNC_size2 _sub_group_block_read_us
#define BLOCK_READ_FUNC_size4 _sub_group_block_read
#define BLOCK_READ_FUNC_size8 _sub_group_block_read_ul
#define BLOCK_READ_FUNC(type_size) CAT(BLOCK_READ_FUNC_size, type_size)
#define BLOCK_READN_FUNC_SIZE_DEF(type_size, vector_size) MAKE_VECTOR_TYPE(BLOCK_READ_FUNC(type_size), vector_size)
#define BLOCK_READN_FUNC_size1(vector_size) BLOCK_READN_FUNC_SIZE_DEF(1, vector_size)
#define BLOCK_READN_FUNC_size2(vector_size) BLOCK_READN_FUNC_SIZE_DEF(2, vector_size)
#define BLOCK_READN_FUNC_size4(vector_size) BLOCK_READN_FUNC_SIZE_DEF(4, vector_size)
#define BLOCK_READN_FUNC_size8(vector_size) BLOCK_READN_FUNC_SIZE_DEF(8, vector_size)
#define BLOCK_READN_FUNC(type_size, vector_size) CAT(BLOCK_READN_FUNC_size, type_size)(vector_size)
#define BLOCK_READN_RAW(type_size, vector_size, addr_space, ptr, offset) BLOCK_READN_FUNC(type_size, vector_size)((const addr_space BLOCK_READ_TYPE(type_size)*)(ptr) + (offset))
#define BLOCK_READN(type, vector_size, ptr, offset) AS_TYPE(MAKE_VECTOR_TYPE(type, vector_size), BLOCK_READN_RAW(TYPE_SIZE(type), vector_size, __global, ptr, offset))
#define BLOCK_READN_SLM(type, vector_size, ptr, offset) AS_TYPE(MAKE_VECTOR_TYPE(type, vector_size), BLOCK_READN_RAW(TYPE_SIZE(type), vector_size, __local, ptr, offset))
#define DT_INPUT_BLOCK_READ(ptr, offset) BLOCK_READN(INPUT0_TYPE, 1, ptr, offset)
#define DT_INPUT_BLOCK_READ2(ptr, offset) BLOCK_READN(INPUT0_TYPE, 2, ptr, offset)
#define DT_INPUT_BLOCK_READ4(ptr, offset) BLOCK_READN(INPUT0_TYPE, 4, ptr, offset)
#define DT_INPUT_BLOCK_READ8(ptr, offset) BLOCK_READN(INPUT0_TYPE, 8, ptr, offset)
#define DT_INPUT_BLOCK_READ16(ptr, offset) BLOCK_READN(INPUT0_TYPE, 16, ptr, offset)
#define DT_BIAS_BLOCK_READ(ptr, offset) BLOCK_READN(BIAS_TYPE, 1, ptr, offset)
#define DT_BIAS_BLOCK_READ2(ptr, offset) BLOCK_READN(BIAS_TYPE, 2, ptr, offset)
#define DT_BIAS_BLOCK_READ4(ptr, offset) BLOCK_READN(BIAS_TYPE, 4, ptr, offset)
#define DT_BIAS_BLOCK_READ8(ptr, offset) BLOCK_READN(BIAS_TYPE, 8, ptr, offset)
#define DT_BIAS_BLOCK_READ16(ptr, offset) BLOCK_READN(BIAS_TYPE, 16, ptr, offset)
#define DT_FILTER_BLOCK_READ(ptr, offset) BLOCK_READN(FILTER_TYPE, 1, ptr, offset)
#define DT_FILTER_BLOCK_READ2(ptr, offset) BLOCK_READN(FILTER_TYPE, 2, ptr, offset)
#define DT_FILTER_BLOCK_READ4(ptr, offset) BLOCK_READN(FILTER_TYPE, 4, ptr, offset)
#define DT_FILTER_BLOCK_READ8(ptr, offset) BLOCK_READN(FILTER_TYPE, 8, ptr, offset)
#define DT_FILTER_BLOCK_READ16(ptr, offset) BLOCK_READN(FILTER_TYPE, 16, ptr, offset)
#define BLOCK_READ_IMPL_1 ret = ptr[idx];
#define BLOCK_READ_IMPL_2 ret.s0 = ptr[idx]; idx += get_max_sub_group_size(); ret.s1 = ptr[idx]; idx += get_max_sub_group_size();
#define BLOCK_READ_IMPL_4 BLOCK_READ_IMPL_2 ret.s2 = ptr[idx]; idx += get_max_sub_group_size(); ret.s3 = ptr[idx]; idx += get_max_sub_group_size();
#define BLOCK_READ_IMPL_8 BLOCK_READ_IMPL_4 ret.s4 = ptr[idx]; idx += get_max_sub_group_size(); ret.s5 = ptr[idx]; idx += get_max_sub_group_size(); ret.s6 = ptr[idx]; idx += get_max_sub_group_size(); ret.s7 = ptr[idx]; idx += get_max_sub_group_size();
#define BLOCK_READ_IMPL_16 BLOCK_READ_IMPL_8 ret.s8 = ptr[idx]; idx += get_max_sub_group_size(); ret.s9 = ptr[idx]; idx += get_max_sub_group_size(); ret.sa = ptr[idx]; idx += get_max_sub_group_size(); ret.sb = ptr[idx]; idx += get_max_sub_group_size(); ret.sc = ptr[idx]; idx += get_max_sub_group_size(); ret.sd = ptr[idx]; idx += get_max_sub_group_size(); ret.se = ptr[idx]; idx += get_max_sub_group_size(); ret.sf = ptr[idx]; idx += get_max_sub_group_size();
#define BLOCK_READ_IMPL(vec_size) CAT(BLOCK_READ_IMPL_, vec_size)
#define BLOCK_READ_FUNC_NAME(type_size, vec_size) MAKE_VECTOR_TYPE(BLOCK_READ_FUNC(type_size), vec_size)
#define DECLARE_BLOCK_READ_EMULATION(type_size, vec_size) inline MAKE_VECTOR_TYPE(BLOCK_READ_TYPE(type_size), vec_size) BLOCK_READ_FUNC_NAME(type_size, vec_size)(const __global BLOCK_READ_TYPE(type_size)* ptr) { uint idx = get_sub_group_local_id(); MAKE_VECTOR_TYPE(BLOCK_READ_TYPE(type_size), vec_size) ret; BLOCK_READ_IMPL(vec_size) return ret; }
#if defined(cl_intel_subgroups)
 #define _sub_group_block_read(ptr) intel_sub_group_block_read(ptr)
 #define _sub_group_block_read2(ptr) intel_sub_group_block_read2(ptr)
 #define _sub_group_block_read4(ptr) intel_sub_group_block_read4(ptr)
 #define _sub_group_block_read8(ptr) intel_sub_group_block_read8(ptr)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_READ_EMULATION(4, 1)
 DECLARE_BLOCK_READ_EMULATION(4, 2)
 DECLARE_BLOCK_READ_EMULATION(4, 4)
 DECLARE_BLOCK_READ_EMULATION(4, 8)
#endif
#if defined(cl_intel_subgroups_short)
 #define _sub_group_block_read_us(ptr) intel_sub_group_block_read_us(ptr)
 #define _sub_group_block_read_us2(ptr) intel_sub_group_block_read_us2(ptr)
 #define _sub_group_block_read_us4(ptr) intel_sub_group_block_read_us4(ptr)
 #define _sub_group_block_read_us8(ptr) intel_sub_group_block_read_us8(ptr)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_READ_EMULATION(2, 1)
 DECLARE_BLOCK_READ_EMULATION(2, 2)
 DECLARE_BLOCK_READ_EMULATION(2, 4)
 DECLARE_BLOCK_READ_EMULATION(2, 8)
#endif
#if defined(cl_intel_subgroups_char)
 #define _sub_group_block_read_uc(ptr) intel_sub_group_block_read_uc(ptr)
 #define _sub_group_block_read_uc2(ptr) intel_sub_group_block_read_uc2(ptr)
 #define _sub_group_block_read_uc4(ptr) intel_sub_group_block_read_uc4(ptr)
 #define _sub_group_block_read_uc8(ptr) intel_sub_group_block_read_uc8(ptr)
 #define _sub_group_block_read_uc16(ptr) intel_sub_group_block_read_uc16(ptr)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_READ_EMULATION(1, 1)
 DECLARE_BLOCK_READ_EMULATION(1, 2)
 DECLARE_BLOCK_READ_EMULATION(1, 4)
 DECLARE_BLOCK_READ_EMULATION(1, 8)
 DECLARE_BLOCK_READ_EMULATION(1, 16)
#endif
#if defined(cl_intel_subgroups_long)
 #define _sub_group_block_read_ul(ptr) intel_sub_group_block_read_ul(ptr)
 #define _sub_group_block_read_ul2(ptr) intel_sub_group_block_read_ul2(ptr)
 #define _sub_group_block_read_ul4(ptr) intel_sub_group_block_read_ul4(ptr)
 #define _sub_group_block_read_ul8(ptr) intel_sub_group_block_read_ul8(ptr)
#elif (__OPENCL_C_VERSION__ >= 200)
 DECLARE_BLOCK_READ_EMULATION(8, 1)
 DECLARE_BLOCK_READ_EMULATION(8, 2)
 DECLARE_BLOCK_READ_EMULATION(8, 4)
 DECLARE_BLOCK_READ_EMULATION(8, 8)
#endif

typedef struct half1 { half s0; } half1;
typedef struct half5 { half s0; half s1; half s2; half s3; half s4; } half5;
typedef struct half6 { half s0; half s1; half s2; half s3; half s4; half s5; } half6;
typedef struct half7 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; } half7;
typedef struct half9 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; } half9;
typedef struct half10 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; half s9; } half10;
typedef struct half11 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; half s9; half sa; } half11;
typedef struct half12 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; half s9; half sa; half sb;} half12;
typedef struct half13 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; half s9; half sa; half sb; half sc;} half13;
typedef struct half14 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; half s9; half sa; half sb; half sc; half se;} half14;
typedef struct half15 { half s0; half s1; half s2; half s3; half s4; half s5; half s6; half s7;
 half s8; half s9; half sa; half sb; half sc; half se; half sf;} half15;
typedef struct half0 { half s0; } half0;
typedef struct float1 { float s0; } float1;
typedef struct float5 { float s0; float s1; float s2; float s3; float s4; } float5;
typedef struct float6 { float s0; float s1; float s2; float s3; float s4; float s5; } float6;
typedef struct float7 { float s0; float s1; float s2; float s3; float s4; float s5; float s6; } float7;
typedef struct float9 { float s0; float s1; float s2; float s3; float s4; float s5; float s6; float s7; float s8; } float9;
typedef struct float10 { float s0; float s1; float s2; float s3; float s4; float s5;
 float s6; float s7; float s8; float s9;} float10;
typedef struct float11 { float s0; float s1; float s2; float s3; float s4; float s5;
 float s6; float s7; float s8; float s9; float sa;} float11;
typedef struct float12 { float s0; float s1; float s2; float s3; float s4; float s5;
 float s6; float s7; float s8; float s9; float sa; float sb; } float12;
typedef struct float13 { float s0; float s1; float s2; float s3; float s4; float s5;
 float s6; float s7; float s8; float s9; float sa; float sb; float sc;} float13;
typedef struct float14 { float s0; float s1; float s2; float s3; float s4; float s5;
 float s6; float s7; float s8; float s9; float sa; float sb; float sc; float sd; } float14;
typedef struct float15 { float s0; float s1; float s2; float s3; float s4; float s5;
 float s6; float s7; float s8; float s9; float sa; float sb; float sc; float sd; float se; } float15;
typedef struct float0 { float s0; } float0;

#ifdef cl_intel_subgroups
#define _sub_group_shuffle(v, c) intel_sub_group_shuffle(v, c)
#define _sub_group_shuffle_up(c, n, d) intel_sub_group_shuffle_up(c, n, d)
#define _sub_group_shuffle_down(c, n, d) intel_sub_group_shuffle_down(c, n, d)
#elif (__OPENCL_C_VERSION__ >= 200)
#define DECLARE_SUB_GROUP_SHUFFLE1(type, cast_type) inline type _sub_group_shuffle(type v, uint c) __attribute__((overloadable)) { return AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v), c)); }
#define DECLARE_SUB_GROUP_SHUFFLE2(type, cast_type) inline CAT(type, 2) _sub_group_shuffle(CAT(type, 2) v, uint c) __attribute__((overloadable)) { return (CAT(type, 2))( AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s0), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s1), c))); }
#define DECLARE_SUB_GROUP_SHUFFLE4(type, cast_type) inline CAT(type, 4) _sub_group_shuffle(CAT(type, 4) v, uint c) __attribute__((overloadable)) { return (CAT(type, 4))( AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s0), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s1), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s2), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s3), c))); }
#define DECLARE_SUB_GROUP_SHUFFLE8(type, cast_type) inline CAT(type, 8) _sub_group_shuffle(CAT(type, 8) v, uint c) __attribute__((overloadable)) { return (CAT(type, 8))( AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s0), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s1), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s2), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s3), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s4), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s5), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s6), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s7), c))); }
#define DECLARE_SUB_GROUP_SHUFFLE16(type, cast_type) inline CAT(type, 16) _sub_group_shuffle(CAT(type, 16) v, uint c) __attribute__((overloadable)) { return (CAT(type, 16))( AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s0), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s1), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s2), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s3), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s4), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s5), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s6), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s7), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s8), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.s9), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.sa), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.sb), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.sc), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.sd), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.se), c)), AS_TYPE(type, sub_group_broadcast(AS_TYPE(cast_type, v.sf), c))); }
#define DECLARE_SUB_GROUP_SHUFFLE(type) DECLARE_SUB_GROUP_SHUFFLE1(type, type) DECLARE_SUB_GROUP_SHUFFLE2(type, type) DECLARE_SUB_GROUP_SHUFFLE4(type, type) DECLARE_SUB_GROUP_SHUFFLE8(type, type) DECLARE_SUB_GROUP_SHUFFLE16(type, type)
#define DECLARE_SUB_GROUP_SHUFFLE_CASTED(type, cast_type) DECLARE_SUB_GROUP_SHUFFLE1(type, cast_type) DECLARE_SUB_GROUP_SHUFFLE2(type, cast_type) DECLARE_SUB_GROUP_SHUFFLE4(type, cast_type) DECLARE_SUB_GROUP_SHUFFLE8(type, cast_type) DECLARE_SUB_GROUP_SHUFFLE16(type, cast_type)
DECLARE_SUB_GROUP_SHUFFLE(int)
DECLARE_SUB_GROUP_SHUFFLE(uint)
DECLARE_SUB_GROUP_SHUFFLE(float)
#if defined(cl_khr_fp16)
 DECLARE_SUB_GROUP_SHUFFLE(half)
 DECLARE_SUB_GROUP_SHUFFLE_CASTED(short, half)
 DECLARE_SUB_GROUP_SHUFFLE_CASTED(ushort, half)
#endif
#endif

//====================================================
// Kernel template: softmax_gpu_bf 
// Kernel name: softmax_gpu_bf_7946080407788828040_0
#define KERNEL(name) __kernel void softmax_gpu_bf_7946080407788828040_0
#define FUNC(name)  _##name##_softmax_gpu_bf_7946080407788828040_0
#define FUNC_CALL(name)  _##name##_softmax_gpu_bf_7946080407788828040_0
#define CONST_ARRAY_DECL(name) __constant size_t  _##name##_softmax_gpu_bf_7946080407788828040_0 []
#define CONST_ARRAY_REF(name)  _##name##_softmax_gpu_bf_7946080407788828040_0
#define FP64_SUPPORTED 0
#define FP16_SUPPORTED 1
#define FP16_UNIT_USED 1
#define INT8_UNIT_USED 0
#define INT32_UNIT_USED 0
#define INT64_UNIT_USED 0
#define UINT8_UNIT_USED 0
#define UINT32_UNIT_USED 0
#define UNIT_TYPE half
#define UNIT_VAL_MAX HALF_MAX
#define UNIT_VAL_MIN -UNIT_VAL_MAX
#define UNIT_VAL_ONE 1.0h
#define UNIT_VAL_ZERO 0.0h
#define TO_UNIT_TYPE(v) convert_half(v)
#define TO_UNIT_TYPE_SAT(v) convert_half(v)
#define AS_UNIT_TYPE(v) as_half(v)
#define UNIT_MAX_FUNC fmax
#define UNIT_MIN_FUNC fmin
#define UNIT_ABS_FUNC fabs
#define UNIT_TYPE_SIZE 2
#define UNIT_IS_FP 1
#define NL_M as_float(0x0)/*0.000000e+00*/
#define NL_N as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPE half
#define ACTIVATION_FUNC_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_VAL_MIN -ACTIVATION_FUNC_VAL_MAX
#define ACTIVATION_FUNC_VAL_ONE 1.0h
#define ACTIVATION_FUNC_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_MAX_FUNC fmax
#define ACTIVATION_FUNC_MIN_FUNC fmin
#define ACTIVATION_FUNC_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPE_SIZE 2
#define ACTIVATION_FUNC_IS_FP 1
#define ACTIVATION_PARAMS NL_M, NL_N
#define ACTIVATION_FUNC(input, m, n) input
#define ACTIVATION(input, params) ACTIVATION_FUNC(input, params)
#define INPUT0_SIZE_X 1
#define INPUT0_SIZE_Y 1
#define INPUT0_SIZE_Z 1
#define INPUT0_SIZE_W 1
#define INPUT0_SIZE_U 1
#define INPUT0_SIZE_V 1
#define INPUT0_FEATURE_NUM 128
#define INPUT0_BATCH_NUM 10
#define INPUT0_PAD_BEFORE_SIZE_X 0
#define INPUT0_PAD_BEFORE_SIZE_Y 0
#define INPUT0_PAD_BEFORE_SIZE_Z 0
#define INPUT0_PAD_BEFORE_SIZE_W 0
#define INPUT0_PAD_BEFORE_SIZE_U 0
#define INPUT0_PAD_BEFORE_SIZE_V 0
#define INPUT0_PAD_BEFORE_FEATURE_NUM 0
#define INPUT0_PAD_BEFORE_BATCH_NUM 0
#define INPUT0_PAD_AFTER_SIZE_X 0
#define INPUT0_PAD_AFTER_SIZE_Y 0
#define INPUT0_PAD_AFTER_SIZE_Z 0
#define INPUT0_PAD_AFTER_SIZE_W 0
#define INPUT0_PAD_AFTER_SIZE_U 0
#define INPUT0_PAD_AFTER_SIZE_V 0
#define INPUT0_PAD_AFTER_FEATURE_NUM 0
#define INPUT0_PAD_AFTER_BATCH_NUM 0
#define INPUT0_X_PITCH 1
#define INPUT0_Y_PITCH 1
#define INPUT0_Z_PITCH 1
#define INPUT0_W_PITCH 1
#define INPUT0_U_PITCH 1
#define INPUT0_V_PITCH 1
#define INPUT0_FEATURE_PITCH 1
#define INPUT0_BATCH_PITCH 128
#define INPUT0_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX(b, f, y, x) GET_DATA_INDEX(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(INPUT0, b, f, y, x)
#define INPUT0_VIEW_OFFSET 0
#define INPUT0_LENGTH 1280
#define INPUT0_DIMS 4
#define INPUT0_SIMPLE 1
#define INPUT0_GROUPED 0
#define INPUT0_LAYOUT_BFYX 1
#define INPUT0_TYPE half
#define INPUT0_VAL_MAX HALF_MAX
#define INPUT0_VAL_MIN -INPUT0_VAL_MAX
#define INPUT0_VAL_ONE 1.0h
#define INPUT0_VAL_ZERO 0.0h
#define TO_INPUT0_TYPE(v) convert_half(v)
#define TO_INPUT0_TYPE_SAT(v) convert_half(v)
#define AS_INPUT0_TYPE(v) as_half(v)
#define INPUT0_MAX_FUNC fmax
#define INPUT0_MIN_FUNC fmin
#define INPUT0_ABS_FUNC fabs
#define INPUT0_TYPE_SIZE 2
#define INPUT0_IS_FP 1
#define INPUT0_OFFSET 0
#define INPUT0_SIZES_DATA { 1,1,128,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(INPUT0_SIZES) = INPUT0_SIZES_DATA;
#define INPUT0_SIZES CONST_ARRAY_REF(INPUT0_SIZES)
#define INPUT0_PITCHES (size_t []){ 1,1,1,128,1,1,1,1,1, } 
#define INPUT0_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define INPUT0_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_SIZE_X 1
#define OUTPUT_SIZE_Y 1
#define OUTPUT_SIZE_Z 1
#define OUTPUT_SIZE_W 1
#define OUTPUT_SIZE_U 1
#define OUTPUT_SIZE_V 1
#define OUTPUT_FEATURE_NUM 128
#define OUTPUT_BATCH_NUM 10
#define OUTPUT_PAD_BEFORE_SIZE_X 0
#define OUTPUT_PAD_BEFORE_SIZE_Y 0
#define OUTPUT_PAD_BEFORE_SIZE_Z 0
#define OUTPUT_PAD_BEFORE_SIZE_W 0
#define OUTPUT_PAD_BEFORE_SIZE_U 0
#define OUTPUT_PAD_BEFORE_SIZE_V 0
#define OUTPUT_PAD_BEFORE_FEATURE_NUM 0
#define OUTPUT_PAD_BEFORE_BATCH_NUM 0
#define OUTPUT_PAD_AFTER_SIZE_X 0
#define OUTPUT_PAD_AFTER_SIZE_Y 0
#define OUTPUT_PAD_AFTER_SIZE_Z 0
#define OUTPUT_PAD_AFTER_SIZE_W 0
#define OUTPUT_PAD_AFTER_SIZE_U 0
#define OUTPUT_PAD_AFTER_SIZE_V 0
#define OUTPUT_PAD_AFTER_FEATURE_NUM 0
#define OUTPUT_PAD_AFTER_BATCH_NUM 0
#define OUTPUT_X_PITCH 1
#define OUTPUT_Y_PITCH 1
#define OUTPUT_Z_PITCH 1
#define OUTPUT_W_PITCH 1
#define OUTPUT_U_PITCH 1
#define OUTPUT_V_PITCH 1
#define OUTPUT_FEATURE_PITCH 1
#define OUTPUT_BATCH_PITCH 128
#define OUTPUT_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX(b, f, y, x) GET_DATA_INDEX(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(OUTPUT, b, f, y, x)
#define OUTPUT_VIEW_OFFSET 0
#define OUTPUT_LENGTH 1280
#define OUTPUT_DIMS 4
#define OUTPUT_SIMPLE 1
#define OUTPUT_GROUPED 0
#define OUTPUT_LAYOUT_BFYX 1
#define OUTPUT_TYPE half
#define OUTPUT_VAL_MAX HALF_MAX
#define OUTPUT_VAL_MIN -OUTPUT_VAL_MAX
#define OUTPUT_VAL_ONE 1.0h
#define OUTPUT_VAL_ZERO 0.0h
#define TO_OUTPUT_TYPE(v) convert_half(v)
#define TO_OUTPUT_TYPE_SAT(v) convert_half(v)
#define AS_OUTPUT_TYPE(v) as_half(v)
#define OUTPUT_MAX_FUNC fmax
#define OUTPUT_MIN_FUNC fmin
#define OUTPUT_ABS_FUNC fabs
#define OUTPUT_TYPE_SIZE 2
#define OUTPUT_IS_FP 1
#define OUTPUT_OFFSET 0
#define OUTPUT_SIZES_DATA { 1,1,128,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(OUTPUT_SIZES) = OUTPUT_SIZES_DATA;
#define OUTPUT_SIZES CONST_ARRAY_REF(OUTPUT_SIZES)
#define OUTPUT_PITCHES (size_t []){ 1,1,1,128,1,1,1,1,1, } 
#define OUTPUT_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OPTIONAL_SHAPE_INFO_ARG 
#define OPTIONAL_SHAPE_INFO_TENSOR 
#define ALONG_FEATURE 1
#define ITEMS_NUM 8
#define LWS 16
#define SLM_SIZE 16
#define DATA_SETS_COUNT 10
#define DATA_SET_SIZE 128
#define LEFTOVERS 0
#define STACK_SIZE 9
#define SUB_GROUP_SIZE 16
#define SUBGROUP_BLOCK_SIZE 8
#define ACTIVATION_TYPE half
#define ACTIVATION_VAL_MAX HALF_MAX
#define ACTIVATION_VAL_MIN -ACTIVATION_VAL_MAX
#define ACTIVATION_VAL_ONE 1.0h
#define ACTIVATION_VAL_ZERO 0.0h
#define TO_ACTIVATION_TYPE(v) convert_half(v)
#define TO_ACTIVATION_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_TYPE(v) as_half(v)
#define ACTIVATION_MAX_FUNC fmax
#define ACTIVATION_MIN_FUNC fmin
#define ACTIVATION_ABS_FUNC fabs
#define ACTIVATION_TYPE_SIZE 2
#define ACTIVATION_IS_FP 1


#if SUBGROUP_BLOCK_SIZE == 1
#define BLOCK_READ(ptr, offset) DT_INPUT_BLOCK_READ(ptr, offset)
#define BLOCK_WRITE(ptr, offset, val) DT_OUTPUT_BLOCK_WRITE(ptr, offset, val)
#define BLOCK_TYPE INPUT0_TYPE
#else
#define BLOCK_READ(ptr, offset) CAT(DT_INPUT_BLOCK_READ, SUBGROUP_BLOCK_SIZE)(ptr, offset)
#define BLOCK_WRITE(ptr, offset, val) CAT(DT_OUTPUT_BLOCK_WRITE, SUBGROUP_BLOCK_SIZE)(ptr, offset, val)
#define BLOCK_TYPE MAKE_VECTOR_TYPE(INPUT0_TYPE, SUBGROUP_BLOCK_SIZE)
#endif
#if IS_DYNAMIC
#define CALC_POWER(n) ({uint pos = 0; uint i = n; do { i >>= 1; ++pos; } while (i); --pos;})
#endif
REQD_SUB_GROUP_SIZE(SUB_GROUP_SIZE)
KERNEL (softmax_gpu_continuous_bfyx)(
 OPTIONAL_SHAPE_INFO_ARG
 const __global INPUT0_TYPE* input,
 __global OUTPUT_TYPE* output
#if HAS_FUSED_OPS_DECLS
 , FUSED_OPS_DECLS
#endif
) {
 const uint data_set_idx = get_global_id(1);
 const uint workers_per_data_set = LWS;
 const uint in_data_set_idx = get_global_id(0);
 const uint data_set_size = DATA_SET_SIZE;
 const uint data_sets_count = DATA_SETS_COUNT;
#if !IS_DYNAMIC
 const uint items_num = ITEMS_NUM;
 const uint leftovers = LEFTOVERS;
#else
 const uint power = CALC_POWER(workers_per_data_set);
 const uint items_num = data_set_size>>power;
 const uint leftovers = data_set_size-(items_num<<power);
#endif
 const uint data_set_offset = data_set_idx * data_set_size;
 const uint subgroup_offset = get_sub_group_id() * get_sub_group_size() * items_num;
 INPUT0_TYPE my_chunk[STACK_SIZE];
 INPUT0_TYPE my_maximum = -UNIT_VAL_MAX;
 INPUT0_TYPE my_sum = UNIT_VAL_ZERO;
 __local INPUT0_TYPE lg_storage[SLM_SIZE];
 uint i=0;
#if SUBGROUP_BLOCK_SIZE != 1
 if (workers_per_data_set > SUB_GROUP_SIZE)
 {
 for (; i<items_num - (items_num % SUBGROUP_BLOCK_SIZE); i+=SUBGROUP_BLOCK_SIZE)
 {
 BLOCK_TYPE vec_tmp = BLOCK_READ(input, data_set_offset + subgroup_offset + i * get_sub_group_size());
 for (int j = 0; j < SUBGROUP_BLOCK_SIZE; j++)
 {
 INPUT0_TYPE tmp = vec_tmp[j];
 my_maximum = max(my_maximum, tmp);
 my_chunk[i+j] = tmp;
 }
 }
 }
#endif
 for (; i<items_num; i++)
 {
 INPUT0_TYPE tmp = input[data_set_offset + subgroup_offset + get_sub_group_local_id() + i * get_sub_group_size()];
 my_maximum = max(my_maximum, tmp);
 my_chunk[i] = tmp;
 }
 if (in_data_set_idx < leftovers)
 {
 INPUT0_TYPE tmp = input[data_set_offset + workers_per_data_set * items_num + in_data_set_idx];
 my_maximum = max(my_maximum, tmp);
 my_chunk[items_num] = tmp;
 }
 my_maximum = sub_group_reduce_max(my_maximum);
 if (get_sub_group_local_id() == 0)
 lg_storage[get_sub_group_id()] = my_maximum;
 barrier(CLK_LOCAL_MEM_FENCE);
 if (in_data_set_idx == 0)
 {
 for (uint i=1; i<get_num_sub_groups(); ++i)
 my_maximum = max(my_maximum, lg_storage[i]);
 lg_storage[0] = my_maximum;
 }
 barrier(CLK_LOCAL_MEM_FENCE);
 my_maximum = lg_storage[0];
 barrier(CLK_LOCAL_MEM_FENCE);
 for (uint i=0; i<items_num; ++i)
 {
 INPUT0_TYPE tmp = native_exp(my_chunk[i] - my_maximum);
 my_sum += tmp;
 my_chunk[i] = tmp;
 }
 if (in_data_set_idx < leftovers)
 {
 INPUT0_TYPE tmp = native_exp(my_chunk[items_num] - my_maximum);
 my_sum += tmp;
 my_chunk[items_num] = tmp;
 }
 my_sum = sub_group_reduce_add(my_sum);
 if (get_sub_group_local_id() == 0)
 lg_storage[get_sub_group_id()] = my_sum;
 barrier(CLK_LOCAL_MEM_FENCE);
 if (in_data_set_idx == 0)
 {
 for (uint i=1; i<get_num_sub_groups(); ++i)
 my_sum += lg_storage[i];
 lg_storage[0] = my_sum;
 }
 barrier(CLK_LOCAL_MEM_FENCE);
 my_sum = lg_storage[0];
 i=0;
#if HAS_FUSED_OPS
#if SUBGROUP_BLOCK_SIZE != 1
 if (workers_per_data_set > SUB_GROUP_SIZE)
 {
 for (; i < items_num - (items_num % SUBGROUP_BLOCK_SIZE); i+=SUBGROUP_BLOCK_SIZE)
 {
 BLOCK_TYPE vec_tmp;
 for (int j = 0; j < SUBGROUP_BLOCK_SIZE; j++)
 {
 ACTIVATION_TYPE dequantized = my_chunk[i + j] / my_sum;
 FUSED_OPS_MAIN;
 vec_tmp[j] = FUSED_OPS_RESULT_MAIN;
 }
 BLOCK_WRITE(output, data_set_offset + subgroup_offset + i * get_sub_group_size(), vec_tmp);
 }
 }
#endif
 for (; i<items_num; i++)
 {
 ACTIVATION_TYPE dequantized = my_chunk[i] / my_sum;
 FUSED_OPS_MAIN;
 output[data_set_offset + subgroup_offset + get_sub_group_local_id() + i * get_sub_group_size()] = FUSED_OPS_RESULT_MAIN;
 }
 if (in_data_set_idx < leftovers)
 {
 ACTIVATION_TYPE dequantized = my_chunk[items_num] / my_sum;
 FUSED_OPS_LEFTOVERS;
 output[data_set_offset + workers_per_data_set * items_num + in_data_set_idx] = FUSED_OPS_RESULT_LEFTOVERS;
 }
#else
#if SUBGROUP_BLOCK_SIZE != 1
 if (workers_per_data_set > SUB_GROUP_SIZE)
 {
 for (; i<items_num - (items_num % SUBGROUP_BLOCK_SIZE); i+=SUBGROUP_BLOCK_SIZE)
 {
 BLOCK_TYPE vec_tmp;
 for (int j = 0; j < SUBGROUP_BLOCK_SIZE; j++)
 vec_tmp[j] = ACTIVATION(my_chunk[i + j] / my_sum, ACTIVATION_PARAMS);
 BLOCK_WRITE(output, data_set_offset + subgroup_offset + i * get_sub_group_size(), vec_tmp);
 }
 }
#endif
 for (; i < items_num; i++)
 {
 output[data_set_offset + subgroup_offset + get_sub_group_local_id() + i * get_sub_group_size()] = ACTIVATION(my_chunk[i] / my_sum, ACTIVATION_PARAMS);
 }
 if (in_data_set_idx < leftovers)
 output[data_set_offset + workers_per_data_set * items_num + in_data_set_idx] = ACTIVATION(my_chunk[items_num] / my_sum, ACTIVATION_PARAMS);
#endif
}
#ifdef CALC_POWER
#undef CALC_POWER
#endif
#undef BLOCK_READ
#undef BLOCK_WRITE
#undef BLOCK_TYPE
#ifdef BLOCK_READ
#undef BLOCK_READ
#endif
#ifdef BLOCK_WRITE
#undef BLOCK_WRITE
#endif
#ifdef BLOCK_TYPE
#undef BLOCK_TYPE
#endif
#ifdef BLOCK_READ
#undef BLOCK_READ
#endif
#ifdef BLOCK_WRITE
#undef BLOCK_WRITE
#endif
#ifdef BLOCK_TYPE
#undef BLOCK_TYPE
#endif
#ifdef CALC_POWER
#undef CALC_POWER
#endif
#undef KERNEL
#undef FUNC
#undef FUNC_CALL
#undef CONST_ARRAY_DECL
#undef CONST_ARRAY_REF
#ifdef FP64_SUPPORTED
#undef FP64_SUPPORTED
#endif
#ifdef FP16_SUPPORTED
#undef FP16_SUPPORTED
#endif
#ifdef FP16_UNIT_USED
#undef FP16_UNIT_USED
#endif
#ifdef INT8_UNIT_USED
#undef INT8_UNIT_USED
#endif
#ifdef INT32_UNIT_USED
#undef INT32_UNIT_USED
#endif
#ifdef INT64_UNIT_USED
#undef INT64_UNIT_USED
#endif
#ifdef UINT8_UNIT_USED
#undef UINT8_UNIT_USED
#endif
#ifdef UINT32_UNIT_USED
#undef UINT32_UNIT_USED
#endif
#ifdef UNIT_TYPE
#undef UNIT_TYPE
#endif
#ifdef UNIT_VAL_MAX
#undef UNIT_VAL_MAX
#endif
#ifdef UNIT_VAL_MIN
#undef UNIT_VAL_MIN
#endif
#ifdef UNIT_VAL_ONE
#undef UNIT_VAL_ONE
#endif
#ifdef UNIT_VAL_ZERO
#undef UNIT_VAL_ZERO
#endif
#ifdef TO_UNIT_TYPE
#undef TO_UNIT_TYPE
#endif
#ifdef TO_UNIT_TYPE_SAT
#undef TO_UNIT_TYPE_SAT
#endif
#ifdef AS_UNIT_TYPE
#undef AS_UNIT_TYPE
#endif
#ifdef UNIT_MAX_FUNC
#undef UNIT_MAX_FUNC
#endif
#ifdef UNIT_MIN_FUNC
#undef UNIT_MIN_FUNC
#endif
#ifdef UNIT_ABS_FUNC
#undef UNIT_ABS_FUNC
#endif
#ifdef UNIT_TYPE_SIZE
#undef UNIT_TYPE_SIZE
#endif
#ifdef UNIT_IS_FP
#undef UNIT_IS_FP
#endif
#ifdef NL_M
#undef NL_M
#endif
#ifdef NL_N
#undef NL_N
#endif
#ifdef ACTIVATION_FUNC_TYPE
#undef ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_VAL_MAX
#undef ACTIVATION_FUNC_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_VAL_MIN
#undef ACTIVATION_FUNC_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_VAL_ONE
#undef ACTIVATION_FUNC_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_VAL_ZERO
#undef ACTIVATION_FUNC_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE
#undef TO_ACTIVATION_FUNC_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPE
#undef AS_ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_MAX_FUNC
#undef ACTIVATION_FUNC_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_MIN_FUNC
#undef ACTIVATION_FUNC_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_ABS_FUNC
#undef ACTIVATION_FUNC_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_IS_FP
#undef ACTIVATION_FUNC_IS_FP
#endif
#ifdef ACTIVATION_PARAMS
#undef ACTIVATION_PARAMS
#endif
#ifdef ACTIVATION_FUNC
#undef ACTIVATION_FUNC
#endif
#ifdef ACTIVATION
#undef ACTIVATION
#endif
#ifdef INPUT0_SIZE_X
#undef INPUT0_SIZE_X
#endif
#ifdef INPUT0_SIZE_Y
#undef INPUT0_SIZE_Y
#endif
#ifdef INPUT0_SIZE_Z
#undef INPUT0_SIZE_Z
#endif
#ifdef INPUT0_SIZE_W
#undef INPUT0_SIZE_W
#endif
#ifdef INPUT0_SIZE_U
#undef INPUT0_SIZE_U
#endif
#ifdef INPUT0_SIZE_V
#undef INPUT0_SIZE_V
#endif
#ifdef INPUT0_FEATURE_NUM
#undef INPUT0_FEATURE_NUM
#endif
#ifdef INPUT0_BATCH_NUM
#undef INPUT0_BATCH_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_X
#undef INPUT0_PAD_BEFORE_SIZE_X
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Y
#undef INPUT0_PAD_BEFORE_SIZE_Y
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Z
#undef INPUT0_PAD_BEFORE_SIZE_Z
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_W
#undef INPUT0_PAD_BEFORE_SIZE_W
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_U
#undef INPUT0_PAD_BEFORE_SIZE_U
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_V
#undef INPUT0_PAD_BEFORE_SIZE_V
#endif
#ifdef INPUT0_PAD_BEFORE_FEATURE_NUM
#undef INPUT0_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_BATCH_NUM
#undef INPUT0_PAD_BEFORE_BATCH_NUM
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_X
#undef INPUT0_PAD_AFTER_SIZE_X
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Y
#undef INPUT0_PAD_AFTER_SIZE_Y
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Z
#undef INPUT0_PAD_AFTER_SIZE_Z
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_W
#undef INPUT0_PAD_AFTER_SIZE_W
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_U
#undef INPUT0_PAD_AFTER_SIZE_U
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_V
#undef INPUT0_PAD_AFTER_SIZE_V
#endif
#ifdef INPUT0_PAD_AFTER_FEATURE_NUM
#undef INPUT0_PAD_AFTER_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_AFTER_BATCH_NUM
#undef INPUT0_PAD_AFTER_BATCH_NUM
#endif
#ifdef INPUT0_X_PITCH
#undef INPUT0_X_PITCH
#endif
#ifdef INPUT0_Y_PITCH
#undef INPUT0_Y_PITCH
#endif
#ifdef INPUT0_Z_PITCH
#undef INPUT0_Z_PITCH
#endif
#ifdef INPUT0_W_PITCH
#undef INPUT0_W_PITCH
#endif
#ifdef INPUT0_U_PITCH
#undef INPUT0_U_PITCH
#endif
#ifdef INPUT0_V_PITCH
#undef INPUT0_V_PITCH
#endif
#ifdef INPUT0_FEATURE_PITCH
#undef INPUT0_FEATURE_PITCH
#endif
#ifdef INPUT0_BATCH_PITCH
#undef INPUT0_BATCH_PITCH
#endif
#ifdef INPUT0_GET_INDEX_SAFE
#undef INPUT0_GET_INDEX_SAFE
#endif
#ifdef INPUT0_GET_INDEX
#undef INPUT0_GET_INDEX
#endif
#ifdef INPUT0_GET_INDEX_RAW
#undef INPUT0_GET_INDEX_RAW
#endif
#ifdef INPUT0_VIEW_OFFSET
#undef INPUT0_VIEW_OFFSET
#endif
#ifdef INPUT0_LENGTH
#undef INPUT0_LENGTH
#endif
#ifdef INPUT0_DIMS
#undef INPUT0_DIMS
#endif
#ifdef INPUT0_SIMPLE
#undef INPUT0_SIMPLE
#endif
#ifdef INPUT0_GROUPED
#undef INPUT0_GROUPED
#endif
#ifdef INPUT0_LAYOUT_BFYX
#undef INPUT0_LAYOUT_BFYX
#endif
#ifdef INPUT0_TYPE
#undef INPUT0_TYPE
#endif
#ifdef INPUT0_VAL_MAX
#undef INPUT0_VAL_MAX
#endif
#ifdef INPUT0_VAL_MIN
#undef INPUT0_VAL_MIN
#endif
#ifdef INPUT0_VAL_ONE
#undef INPUT0_VAL_ONE
#endif
#ifdef INPUT0_VAL_ZERO
#undef INPUT0_VAL_ZERO
#endif
#ifdef TO_INPUT0_TYPE
#undef TO_INPUT0_TYPE
#endif
#ifdef TO_INPUT0_TYPE_SAT
#undef TO_INPUT0_TYPE_SAT
#endif
#ifdef AS_INPUT0_TYPE
#undef AS_INPUT0_TYPE
#endif
#ifdef INPUT0_MAX_FUNC
#undef INPUT0_MAX_FUNC
#endif
#ifdef INPUT0_MIN_FUNC
#undef INPUT0_MIN_FUNC
#endif
#ifdef INPUT0_ABS_FUNC
#undef INPUT0_ABS_FUNC
#endif
#ifdef INPUT0_TYPE_SIZE
#undef INPUT0_TYPE_SIZE
#endif
#ifdef INPUT0_IS_FP
#undef INPUT0_IS_FP
#endif
#ifdef INPUT0_OFFSET
#undef INPUT0_OFFSET
#endif
#ifdef INPUT0_SIZES_DATA
#undef INPUT0_SIZES_DATA
#endif
#ifdef INPUT0_PITCHES
#undef INPUT0_PITCHES
#endif
#ifdef INPUT0_PAD_BEFORE
#undef INPUT0_PAD_BEFORE
#endif
#ifdef INPUT0_PAD_AFTER
#undef INPUT0_PAD_AFTER
#endif
#ifdef OUTPUT_SIZE_X
#undef OUTPUT_SIZE_X
#endif
#ifdef OUTPUT_SIZE_Y
#undef OUTPUT_SIZE_Y
#endif
#ifdef OUTPUT_SIZE_Z
#undef OUTPUT_SIZE_Z
#endif
#ifdef OUTPUT_SIZE_W
#undef OUTPUT_SIZE_W
#endif
#ifdef OUTPUT_SIZE_U
#undef OUTPUT_SIZE_U
#endif
#ifdef OUTPUT_SIZE_V
#undef OUTPUT_SIZE_V
#endif
#ifdef OUTPUT_FEATURE_NUM
#undef OUTPUT_FEATURE_NUM
#endif
#ifdef OUTPUT_BATCH_NUM
#undef OUTPUT_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_X
#undef OUTPUT_PAD_BEFORE_SIZE_X
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Y
#undef OUTPUT_PAD_BEFORE_SIZE_Y
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Z
#undef OUTPUT_PAD_BEFORE_SIZE_Z
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_W
#undef OUTPUT_PAD_BEFORE_SIZE_W
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_U
#undef OUTPUT_PAD_BEFORE_SIZE_U
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_V
#undef OUTPUT_PAD_BEFORE_SIZE_V
#endif
#ifdef OUTPUT_PAD_BEFORE_FEATURE_NUM
#undef OUTPUT_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_BATCH_NUM
#undef OUTPUT_PAD_BEFORE_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_X
#undef OUTPUT_PAD_AFTER_SIZE_X
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Y
#undef OUTPUT_PAD_AFTER_SIZE_Y
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Z
#undef OUTPUT_PAD_AFTER_SIZE_Z
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_W
#undef OUTPUT_PAD_AFTER_SIZE_W
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_U
#undef OUTPUT_PAD_AFTER_SIZE_U
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_V
#undef OUTPUT_PAD_AFTER_SIZE_V
#endif
#ifdef OUTPUT_PAD_AFTER_FEATURE_NUM
#undef OUTPUT_PAD_AFTER_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_BATCH_NUM
#undef OUTPUT_PAD_AFTER_BATCH_NUM
#endif
#ifdef OUTPUT_X_PITCH
#undef OUTPUT_X_PITCH
#endif
#ifdef OUTPUT_Y_PITCH
#undef OUTPUT_Y_PITCH
#endif
#ifdef OUTPUT_Z_PITCH
#undef OUTPUT_Z_PITCH
#endif
#ifdef OUTPUT_W_PITCH
#undef OUTPUT_W_PITCH
#endif
#ifdef OUTPUT_U_PITCH
#undef OUTPUT_U_PITCH
#endif
#ifdef OUTPUT_V_PITCH
#undef OUTPUT_V_PITCH
#endif
#ifdef OUTPUT_FEATURE_PITCH
#undef OUTPUT_FEATURE_PITCH
#endif
#ifdef OUTPUT_BATCH_PITCH
#undef OUTPUT_BATCH_PITCH
#endif
#ifdef OUTPUT_GET_INDEX_SAFE
#undef OUTPUT_GET_INDEX_SAFE
#endif
#ifdef OUTPUT_GET_INDEX
#undef OUTPUT_GET_INDEX
#endif
#ifdef OUTPUT_GET_INDEX_RAW
#undef OUTPUT_GET_INDEX_RAW
#endif
#ifdef OUTPUT_VIEW_OFFSET
#undef OUTPUT_VIEW_OFFSET
#endif
#ifdef OUTPUT_LENGTH
#undef OUTPUT_LENGTH
#endif
#ifdef OUTPUT_DIMS
#undef OUTPUT_DIMS
#endif
#ifdef OUTPUT_SIMPLE
#undef OUTPUT_SIMPLE
#endif
#ifdef OUTPUT_GROUPED
#undef OUTPUT_GROUPED
#endif
#ifdef OUTPUT_LAYOUT_BFYX
#undef OUTPUT_LAYOUT_BFYX
#endif
#ifdef OUTPUT_TYPE
#undef OUTPUT_TYPE
#endif
#ifdef OUTPUT_VAL_MAX
#undef OUTPUT_VAL_MAX
#endif
#ifdef OUTPUT_VAL_MIN
#undef OUTPUT_VAL_MIN
#endif
#ifdef OUTPUT_VAL_ONE
#undef OUTPUT_VAL_ONE
#endif
#ifdef OUTPUT_VAL_ZERO
#undef OUTPUT_VAL_ZERO
#endif
#ifdef TO_OUTPUT_TYPE
#undef TO_OUTPUT_TYPE
#endif
#ifdef TO_OUTPUT_TYPE_SAT
#undef TO_OUTPUT_TYPE_SAT
#endif
#ifdef AS_OUTPUT_TYPE
#undef AS_OUTPUT_TYPE
#endif
#ifdef OUTPUT_MAX_FUNC
#undef OUTPUT_MAX_FUNC
#endif
#ifdef OUTPUT_MIN_FUNC
#undef OUTPUT_MIN_FUNC
#endif
#ifdef OUTPUT_ABS_FUNC
#undef OUTPUT_ABS_FUNC
#endif
#ifdef OUTPUT_TYPE_SIZE
#undef OUTPUT_TYPE_SIZE
#endif
#ifdef OUTPUT_IS_FP
#undef OUTPUT_IS_FP
#endif
#ifdef OUTPUT_OFFSET
#undef OUTPUT_OFFSET
#endif
#ifdef OUTPUT_SIZES_DATA
#undef OUTPUT_SIZES_DATA
#endif
#ifdef OUTPUT_PITCHES
#undef OUTPUT_PITCHES
#endif
#ifdef OUTPUT_PAD_BEFORE
#undef OUTPUT_PAD_BEFORE
#endif
#ifdef OUTPUT_PAD_AFTER
#undef OUTPUT_PAD_AFTER
#endif
#ifdef OPTIONAL_SHAPE_INFO_ARG
#undef OPTIONAL_SHAPE_INFO_ARG
#endif
#ifdef OPTIONAL_SHAPE_INFO_TENSOR
#undef OPTIONAL_SHAPE_INFO_TENSOR
#endif
#ifdef ALONG_FEATURE
#undef ALONG_FEATURE
#endif
#ifdef ITEMS_NUM
#undef ITEMS_NUM
#endif
#ifdef LWS
#undef LWS
#endif
#ifdef SLM_SIZE
#undef SLM_SIZE
#endif
#ifdef DATA_SETS_COUNT
#undef DATA_SETS_COUNT
#endif
#ifdef DATA_SET_SIZE
#undef DATA_SET_SIZE
#endif
#ifdef LEFTOVERS
#undef LEFTOVERS
#endif
#ifdef STACK_SIZE
#undef STACK_SIZE
#endif
#ifdef SUB_GROUP_SIZE
#undef SUB_GROUP_SIZE
#endif
#ifdef SUBGROUP_BLOCK_SIZE
#undef SUBGROUP_BLOCK_SIZE
#endif
#ifdef ACTIVATION_TYPE
#undef ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_VAL_MAX
#undef ACTIVATION_VAL_MAX
#endif
#ifdef ACTIVATION_VAL_MIN
#undef ACTIVATION_VAL_MIN
#endif
#ifdef ACTIVATION_VAL_ONE
#undef ACTIVATION_VAL_ONE
#endif
#ifdef ACTIVATION_VAL_ZERO
#undef ACTIVATION_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_TYPE
#undef TO_ACTIVATION_TYPE
#endif
#ifdef TO_ACTIVATION_TYPE_SAT
#undef TO_ACTIVATION_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_TYPE
#undef AS_ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_MAX_FUNC
#undef ACTIVATION_MAX_FUNC
#endif
#ifdef ACTIVATION_MIN_FUNC
#undef ACTIVATION_MIN_FUNC
#endif
#ifdef ACTIVATION_ABS_FUNC
#undef ACTIVATION_ABS_FUNC
#endif
#ifdef ACTIVATION_TYPE_SIZE
#undef ACTIVATION_TYPE_SIZE
#endif
#ifdef ACTIVATION_IS_FP
#undef ACTIVATION_IS_FP
#endif

//====================================================
// Kernel template: reorder_data 
// Kernel name: reorder_data_15652857777958573679_0
#define KERNEL(name) __kernel void reorder_data_15652857777958573679_0
#define FUNC(name)  _##name##_reorder_data_15652857777958573679_0
#define FUNC_CALL(name)  _##name##_reorder_data_15652857777958573679_0
#define CONST_ARRAY_DECL(name) __constant size_t  _##name##_reorder_data_15652857777958573679_0 []
#define CONST_ARRAY_REF(name)  _##name##_reorder_data_15652857777958573679_0
#define FP64_SUPPORTED 0
#define FP16_SUPPORTED 1
#define FP16_UNIT_USED 1
#define INT8_UNIT_USED 0
#define INT32_UNIT_USED 0
#define INT64_UNIT_USED 0
#define UINT8_UNIT_USED 0
#define UINT32_UNIT_USED 0
#define UNIT_TYPE half
#define UNIT_VAL_MAX HALF_MAX
#define UNIT_VAL_MIN -UNIT_VAL_MAX
#define UNIT_VAL_ONE 1.0h
#define UNIT_VAL_ZERO 0.0h
#define TO_UNIT_TYPE(v) convert_half(v)
#define TO_UNIT_TYPE_SAT(v) convert_half(v)
#define AS_UNIT_TYPE(v) as_half(v)
#define UNIT_MAX_FUNC fmax
#define UNIT_MIN_FUNC fmin
#define UNIT_ABS_FUNC fabs
#define UNIT_TYPE_SIZE 2
#define UNIT_IS_FP 1
#define NL_M as_float(0x0)/*0.000000e+00*/
#define NL_N as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPE half
#define ACTIVATION_FUNC_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_VAL_MIN -ACTIVATION_FUNC_VAL_MAX
#define ACTIVATION_FUNC_VAL_ONE 1.0h
#define ACTIVATION_FUNC_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_MAX_FUNC fmax
#define ACTIVATION_FUNC_MIN_FUNC fmin
#define ACTIVATION_FUNC_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPE_SIZE 2
#define ACTIVATION_FUNC_IS_FP 1
#define ACTIVATION_PARAMS NL_M, NL_N
#define ACTIVATION_FUNC(input, m, n) input
#define ACTIVATION(input, params) ACTIVATION_FUNC(input, params)
#define INPUT0_SIZE_X 1
#define INPUT0_SIZE_Y 1
#define INPUT0_SIZE_Z 1
#define INPUT0_SIZE_W 1
#define INPUT0_SIZE_U 1
#define INPUT0_SIZE_V 1
#define INPUT0_FEATURE_NUM 128
#define INPUT0_BATCH_NUM 10
#define INPUT0_PAD_BEFORE_SIZE_X 0
#define INPUT0_PAD_BEFORE_SIZE_Y 0
#define INPUT0_PAD_BEFORE_SIZE_Z 0
#define INPUT0_PAD_BEFORE_SIZE_W 0
#define INPUT0_PAD_BEFORE_SIZE_U 0
#define INPUT0_PAD_BEFORE_SIZE_V 0
#define INPUT0_PAD_BEFORE_FEATURE_NUM 0
#define INPUT0_PAD_BEFORE_BATCH_NUM 0
#define INPUT0_PAD_AFTER_SIZE_X 0
#define INPUT0_PAD_AFTER_SIZE_Y 0
#define INPUT0_PAD_AFTER_SIZE_Z 0
#define INPUT0_PAD_AFTER_SIZE_W 0
#define INPUT0_PAD_AFTER_SIZE_U 0
#define INPUT0_PAD_AFTER_SIZE_V 0
#define INPUT0_PAD_AFTER_FEATURE_NUM 0
#define INPUT0_PAD_AFTER_BATCH_NUM 0
#define INPUT0_X_PITCH 1
#define INPUT0_Y_PITCH 1
#define INPUT0_Z_PITCH 1
#define INPUT0_W_PITCH 1
#define INPUT0_U_PITCH 1
#define INPUT0_V_PITCH 1
#define INPUT0_FEATURE_PITCH 1
#define INPUT0_BATCH_PITCH 128
#define INPUT0_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX(b, f, y, x) GET_DATA_INDEX(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(INPUT0, b, f, y, x)
#define INPUT0_VIEW_OFFSET 0
#define INPUT0_LENGTH 1280
#define INPUT0_DIMS 4
#define INPUT0_SIMPLE 1
#define INPUT0_GROUPED 0
#define INPUT0_LAYOUT_BFYX 1
#define INPUT0_TYPE half
#define INPUT0_VAL_MAX HALF_MAX
#define INPUT0_VAL_MIN -INPUT0_VAL_MAX
#define INPUT0_VAL_ONE 1.0h
#define INPUT0_VAL_ZERO 0.0h
#define TO_INPUT0_TYPE(v) convert_half(v)
#define TO_INPUT0_TYPE_SAT(v) convert_half(v)
#define AS_INPUT0_TYPE(v) as_half(v)
#define INPUT0_MAX_FUNC fmax
#define INPUT0_MIN_FUNC fmin
#define INPUT0_ABS_FUNC fabs
#define INPUT0_TYPE_SIZE 2
#define INPUT0_IS_FP 1
#define INPUT0_OFFSET 0
#define INPUT0_SIZES_DATA { 1,1,128,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(INPUT0_SIZES) = INPUT0_SIZES_DATA;
#define INPUT0_SIZES CONST_ARRAY_REF(INPUT0_SIZES)
#define INPUT0_PITCHES (size_t []){ 1,1,1,128,1,1,1,1,1, } 
#define INPUT0_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define INPUT0_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_SIZE_X 1
#define OUTPUT_SIZE_Y 1
#define OUTPUT_SIZE_Z 1
#define OUTPUT_SIZE_W 1
#define OUTPUT_SIZE_U 1
#define OUTPUT_SIZE_V 1
#define OUTPUT_FEATURE_NUM 128
#define OUTPUT_BATCH_NUM 10
#define OUTPUT_PAD_BEFORE_SIZE_X 0
#define OUTPUT_PAD_BEFORE_SIZE_Y 0
#define OUTPUT_PAD_BEFORE_SIZE_Z 0
#define OUTPUT_PAD_BEFORE_SIZE_W 0
#define OUTPUT_PAD_BEFORE_SIZE_U 0
#define OUTPUT_PAD_BEFORE_SIZE_V 0
#define OUTPUT_PAD_BEFORE_FEATURE_NUM 0
#define OUTPUT_PAD_BEFORE_BATCH_NUM 0
#define OUTPUT_PAD_AFTER_SIZE_X 0
#define OUTPUT_PAD_AFTER_SIZE_Y 0
#define OUTPUT_PAD_AFTER_SIZE_Z 0
#define OUTPUT_PAD_AFTER_SIZE_W 0
#define OUTPUT_PAD_AFTER_SIZE_U 0
#define OUTPUT_PAD_AFTER_SIZE_V 0
#define OUTPUT_PAD_AFTER_FEATURE_NUM 0
#define OUTPUT_PAD_AFTER_BATCH_NUM 0
#define OUTPUT_X_PITCH 1
#define OUTPUT_Y_PITCH 1
#define OUTPUT_Z_PITCH 1
#define OUTPUT_W_PITCH 1
#define OUTPUT_U_PITCH 1
#define OUTPUT_V_PITCH 1
#define OUTPUT_FEATURE_PITCH 1
#define OUTPUT_BATCH_PITCH 128
#define OUTPUT_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX(b, f, y, x) GET_DATA_INDEX(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(OUTPUT, b, f, y, x)
#define OUTPUT_VIEW_OFFSET 0
#define OUTPUT_LENGTH 1280
#define OUTPUT_DIMS 4
#define OUTPUT_SIMPLE 1
#define OUTPUT_GROUPED 0
#define OUTPUT_LAYOUT_BFYX 1
#define OUTPUT_TYPE float
#define OUTPUT_VAL_MAX FLT_MAX
#define OUTPUT_VAL_MIN -OUTPUT_VAL_MAX
#define OUTPUT_VAL_ONE 1.0f
#define OUTPUT_VAL_ZERO 0.0f
#define TO_OUTPUT_TYPE(v) convert_float(v)
#define TO_OUTPUT_TYPE_SAT(v) convert_float(v)
#define AS_OUTPUT_TYPE(v) as_float(v)
#define OUTPUT_MAX_FUNC fmax
#define OUTPUT_MIN_FUNC fmin
#define OUTPUT_ABS_FUNC fabs
#define OUTPUT_TYPE_SIZE 4
#define OUTPUT_IS_FP 1
#define OUTPUT_OFFSET 0
#define OUTPUT_SIZES_DATA { 1,1,128,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(OUTPUT_SIZES) = OUTPUT_SIZES_DATA;
#define OUTPUT_SIZES CONST_ARRAY_REF(OUTPUT_SIZES)
#define OUTPUT_PITCHES (size_t []){ 1,1,1,128,1,1,1,1,1, } 
#define OUTPUT_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OPTIONAL_SHAPE_INFO_ARG 
#define OPTIONAL_SHAPE_INFO_TENSOR 
#define MEAN_SUBTRACT_NONE 1
#define CALC_TYPE half
#define CALC_VAL_MAX HALF_MAX
#define CALC_VAL_MIN -CALC_VAL_MAX
#define CALC_VAL_ONE 1.0h
#define CALC_VAL_ZERO 0.0h
#define TO_CALC_TYPE(v) convert_half(v)
#define TO_CALC_TYPE_SAT(v) convert_half(v)
#define AS_CALC_TYPE(v) as_half(v)
#define CALC_MAX_FUNC fmax
#define CALC_MIN_FUNC fmin
#define CALC_ABS_FUNC fabs
#define CALC_TYPE_SIZE 2
#define CALC_IS_FP 1
#define INPUT_REORDER_TYPE half
#define INPUT_REORDER_VAL_MAX HALF_MAX
#define INPUT_REORDER_VAL_MIN -INPUT_REORDER_VAL_MAX
#define INPUT_REORDER_VAL_ONE 1.0h
#define INPUT_REORDER_VAL_ZERO 0.0h
#define TO_INPUT_REORDER_TYPE(v) convert_half(v)
#define TO_INPUT_REORDER_TYPE_SAT(v) convert_half(v)
#define AS_INPUT_REORDER_TYPE(v) as_half(v)
#define INPUT_REORDER_MAX_FUNC fmax
#define INPUT_REORDER_MIN_FUNC fmin
#define INPUT_REORDER_ABS_FUNC fabs
#define INPUT_REORDER_TYPE_SIZE 2
#define INPUT_REORDER_IS_FP 1
#define OUTPUT_REORDER_TYPE float
#define OUTPUT_REORDER_VAL_MAX FLT_MAX
#define OUTPUT_REORDER_VAL_MIN -OUTPUT_REORDER_VAL_MAX
#define OUTPUT_REORDER_VAL_ONE 1.0f
#define OUTPUT_REORDER_VAL_ZERO 0.0f
#define TO_OUTPUT_REORDER_TYPE(v) convert_float(v)
#define TO_OUTPUT_REORDER_TYPE_SAT(v) convert_float(v)
#define AS_OUTPUT_REORDER_TYPE(v) as_float(v)
#define OUTPUT_REORDER_MAX_FUNC fmax
#define OUTPUT_REORDER_MIN_FUNC fmin
#define OUTPUT_REORDER_ABS_FUNC fabs
#define OUTPUT_REORDER_TYPE_SIZE 4
#define OUTPUT_REORDER_IS_FP 1
#define MEAN_OP(val, mean_val) val-mean_val
#define NL_M_TYPED as_float(0x0)/*0.000000e+00*/
#define NL_N_TYPED as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPED_TYPE half
#define ACTIVATION_FUNC_TYPED_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_TYPED_VAL_MIN -ACTIVATION_FUNC_TYPED_VAL_MAX
#define ACTIVATION_FUNC_TYPED_VAL_ONE 1.0h
#define ACTIVATION_FUNC_TYPED_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPED_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPED_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPED_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_TYPED_MAX_FUNC fmax
#define ACTIVATION_FUNC_TYPED_MIN_FUNC fmin
#define ACTIVATION_FUNC_TYPED_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPED_TYPE_SIZE 2
#define ACTIVATION_FUNC_TYPED_IS_FP 1
#define ACTIVATION_PARAMS_TYPED NL_M_TYPED, NL_N_TYPED
#define ACTIVATION_FUNC_TYPED(jit_type, input, m, n) input
#define ACTIVATION_TYPED(jit_type, input, params) ACTIVATION_FUNC_TYPED(jit_type, input, params)
#define SUB_GROUP_SIZE 1
#define CONVERT_TRUNCATE 1
#define GWS_BATCH 2
#define GWS_FEATURE 1
#define GWS_YX 0


inline uint8 FUNC(reshape_dims)(
 uint b, uint f, uint v, uint u, uint w, uint z, uint y, uint x,
 uint src_size_f, uint src_size_v, uint src_size_u, uint src_size_w, uint src_size_z, uint src_size_y, uint src_size_x,
 uint dst_size_f, uint dst_size_v, uint dst_size_u, uint dst_size_w, uint dst_size_z, uint dst_size_y, uint dst_size_x,
 uint src_dims, uint dst_dims)
{
 if (dst_dims == src_dims) {
 return (uint8)(b, f, v, u, w, z, y, x);
 }
 const uint src_pitch_x = 1;
 const uint src_pitch_y = src_pitch_x * src_size_x;
 const uint src_pitch_z = src_pitch_y * src_size_y;
 const uint src_pitch_w = src_pitch_z * src_size_z;
 const uint src_pitch_u = src_pitch_w * src_size_w;
 const uint src_pitch_v = src_pitch_u * src_size_u;
 const uint src_pitch_f = src_pitch_v * src_size_v;
 const uint src_pitch_b = src_pitch_f * src_size_f;
 uint flat_idx = x * src_pitch_x
 + y * src_pitch_y
 + z * src_pitch_z
 + w * src_pitch_w
 + u * src_pitch_u
 + v * src_pitch_v
 + f * src_pitch_f
 + b * src_pitch_b;
 uint dst_x = flat_idx % dst_size_x;
 flat_idx /= dst_size_x;
 uint dst_y = flat_idx % dst_size_y;
 flat_idx /= dst_size_y;
 uint dst_z = flat_idx % dst_size_z;
 flat_idx /= dst_size_z;
 uint dst_w = flat_idx % dst_size_w;
 flat_idx /= dst_size_w;
 uint dst_u = flat_idx % dst_size_u;
 flat_idx /= dst_size_u;
 uint dst_v = flat_idx % dst_size_v;
 flat_idx /= dst_size_v;
 uint dst_f = flat_idx % dst_size_f;
 flat_idx /= dst_size_f;
 uint dst_b = flat_idx;
 return (uint8)(dst_b, dst_f, dst_v, dst_u, dst_w, dst_z, dst_y, dst_x);
}
#define RESHAPE_DIMS(src_prefix, dst_prefix, b, f, v, u, w, z, y, x) FUNC_CALL(reshape_dims)( b, f, v, u, w, z, y, x, CAT(src_prefix, _FEATURE_NUM), CAT(src_prefix, _SIZE_V), CAT(src_prefix, _SIZE_U), CAT(src_prefix, _SIZE_W), CAT(src_prefix, _SIZE_Z), CAT(src_prefix, _SIZE_Y), CAT(src_prefix, _SIZE_X), CAT(dst_prefix, _FEATURE_NUM), CAT(dst_prefix, _SIZE_V), CAT(dst_prefix, _SIZE_U), CAT(dst_prefix, _SIZE_W), CAT(dst_prefix, _SIZE_Z), CAT(dst_prefix, _SIZE_Y), CAT(dst_prefix, _SIZE_X), CAT(src_prefix, _DIMS), CAT(dst_prefix, _DIMS))
inline uint FUNC(get_input_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint v, uint u, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
#if INPUT0_DIMS < 5
 return INPUT0_GET_INDEX(b, f, y, x);
#elif INPUT0_DIMS == 5
 return INPUT0_GET_INDEX(b, f, z, y, x);
#elif INPUT0_DIMS == 6
 return INPUT0_GET_INDEX(b, f, w, z, y, x);
#elif INPUT0_DIMS == 7
 return INPUT0_GET_INDEX(b, f, u, w, z, y, x);
#elif INPUT0_DIMS == 8
 return INPUT0_GET_INDEX(b, f, v, u, w, z, y, x);
#else
#error [GPU] Unsupported input tensor rank in get_input_index function
#endif
}
inline uint FUNC(get_input_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
 return FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, f, 0, 0, w, z, y, x);
}
inline uint FUNC(get_output_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint v, uint u, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
#if OUTPUT_DIMS < 5
 return OUTPUT_GET_INDEX(b, f, y, x);
#elif OUTPUT_DIMS == 5
 return OUTPUT_GET_INDEX(b, f, z, y, x);
#elif OUTPUT_DIMS == 6
 return OUTPUT_GET_INDEX(b, f, w, z, y, x);
#elif OUTPUT_DIMS == 7
 return OUTPUT_GET_INDEX(b, f, u, w, z, y, x);
#elif OUTPUT_DIMS == 8
 return OUTPUT_GET_INDEX(b, f, v, u, w, z, y, x);
#else
#error [GPU] Unsupported output tensor rank in get_output_index function
#endif
}
inline uint FUNC(get_output_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
 return FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR b, f, 0, 0, w, z, y, x);
}
#define DECLARE_SAMPLER const sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST
#if FP16_UNIT_USED
 #define IMAGE_READ(image, coord) read_imageh((image), imageSampler, (coord))
 #define IMAGE_WRITE(image, coord, val) write_imageh((image), (coord), (val))
#else
 #define IMAGE_READ(image, coord) read_imagef((image), imageSampler, (coord))
 #define IMAGE_WRITE(image, coord, val) write_imagef((image), (coord), (val))
#endif
#define INPUT_TYPE4 MAKE_VECTOR_TYPE(INPUT_REORDER_TYPE, 4)
#define OUTPUT_TYPE4 MAKE_VECTOR_TYPE(OUTPUT_REORDER_TYPE, 4)
KERNEL (reorder_data)(
 OPTIONAL_SHAPE_INFO_ARG
#if INPUT0_LAYOUT_NV12 || INPUT0_LAYOUT_IMAGE_2D_RGBA || SURFACE_INPUT
 read_only image2d_t input,
#else
 const __global INPUT_REORDER_TYPE* input,
#endif
#if OUTPUT_LAYOUT_IMAGE_2D_RGBA
 write_only image2d_t output
#else
 __global OUTPUT_REORDER_TYPE* output
#endif
#ifdef MEAN_SUBTRACT_IN_BUFFER
 , __global MEAN_SUBTRACT_TYPE* mean_subtract
#endif
 )
{
 const uint b = get_global_id(GWS_BATCH);
 const uint f = get_global_id(GWS_FEATURE);
#if INPUT0_DIMS == 2
 const uint y = 0;
 const uint x = 0;
 const uint z = 0;
 const uint w = 0;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 4
 const uint y = ((uint)(get_global_id(GWS_YX))) / INPUT0_SIZE_X;
 const uint x = ((uint)(get_global_id(GWS_YX))) % INPUT0_SIZE_X;
 const uint z = 0;
 const uint w = 0;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 5
 uint data_idx = get_global_id(GWS_YX);
 uint tmp_data_idx = data_idx / INPUT0_SIZE_X;
 const uint x = data_idx - tmp_data_idx * INPUT0_SIZE_X;
 data_idx = tmp_data_idx;
 tmp_data_idx = data_idx / INPUT0_SIZE_Y;
 const uint y = data_idx - tmp_data_idx * INPUT0_SIZE_Y;
 data_idx = tmp_data_idx;
 tmp_data_idx = data_idx / INPUT0_SIZE_Z;
 const uint z = data_idx - tmp_data_idx * INPUT0_SIZE_Z;
 const uint w = 0;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 6
 const uint gid_yx = (uint)(get_global_id(GWS_YX));
 const uint x = gid_yx % INPUT0_SIZE_X;
 const uint y = gid_yx / INPUT0_SIZE_X % INPUT0_SIZE_Y;
 const uint z = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y % INPUT0_SIZE_Z;
 const uint w = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z % INPUT0_SIZE_W;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 7
 const uint gid_yx = (uint)(get_global_id(GWS_YX));
 const uint x = gid_yx % INPUT0_SIZE_X;
 const uint y = gid_yx / INPUT0_SIZE_X % INPUT0_SIZE_Y;
 const uint z = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y % INPUT0_SIZE_Z;
 const uint w = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z % INPUT0_SIZE_W;
 const uint u = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z / INPUT0_SIZE_W % INPUT0_SIZE_U;
 const uint v = 0;
#elif INPUT0_DIMS == 8
 const uint gid_yx = (uint)(get_global_id(GWS_YX));
 const uint x = gid_yx % INPUT0_SIZE_X;
 const uint y = gid_yx / INPUT0_SIZE_X % INPUT0_SIZE_Y;
 const uint z = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y % INPUT0_SIZE_Z;
 const uint w = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z % INPUT0_SIZE_W;
 const uint u = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z / INPUT0_SIZE_W % INPUT0_SIZE_U;
 const uint v = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z / INPUT0_SIZE_W / INPUT0_SIZE_U % INPUT0_SIZE_V;
#endif
#if defined INPUT0_LAYOUT_NV12 && !SURFACE_INPUT
 const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
 float4 colorVYU = read_imagef(input, sampler, (int2)(x, y));
 float Ycomponent = mad(colorVYU.s1, 296.82f, -18.624f);
 float Ucomponent = mad(colorVYU.s2, 255.0f, -128.f);
 float Vcomponent = mad(colorVYU.s0, 255.0f, -128.f);
 float B = clamp(mad(Vcomponent, 1.596f, Ycomponent), 0.f, 255.f);
 float R = clamp(mad(Ucomponent, 2.018f, Ycomponent), 0.f, 255.f);
 float G = clamp(mad(Vcomponent, -0.813f, mad(Ucomponent, -0.391f, Ycomponent)), 0.f, 255.f);
#elif defined INPUT0_LAYOUT_IMAGE_2D_RGBA
 const sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
 OUTPUT_TYPE4 colorRGBA = IMAGE_READ(input, (int2)(x, y));
#elif defined OUTPUT_LAYOUT_IMAGE_2D_RGBA
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, f, v, u, w, z, y, x);
 const uint input_idx_R = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 0, v, u, w, z, y, x);
 const uint input_idx_G = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 1, v, u, w, z, y, x);
 const uint input_idx_B = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 2, v, u, w, z, y, x);
#if OUTPUT_FEATURE_NUM == 3
 INPUT_TYPE4 colorRGBA = { TO_INPUT_REORDER_TYPE(input[input_idx_R]), TO_INPUT_REORDER_TYPE(input[input_idx_G]), TO_INPUT_REORDER_TYPE(input[input_idx_B]), TO_INPUT_REORDER_TYPE(0.f) };
#else
 const uint input_idx_A = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 3, v, u, w, z, y, x);
 INPUT_TYPE4 colorRGBA = { TO_INPUT_REORDER_TYPE(input[input_idx_R]), TO_INPUT_REORDER_TYPE(input[input_idx_G]), TO_INPUT_REORDER_TYPE(input[input_idx_B]), TO_INPUT_REORDER_TYPE(input[input_idx_A]) };
#endif
#else
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, f, v, u, w, z, y, x);
 const uint input_idx = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, f, v, u, w, z, y, x);
 const uint output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
#if defined MEAN_SUBTRACT_INSIDE_PARAMS
 float res = TO_MEAN_TYPE(input[input_idx]);
 res = MEAN_OP(res, VALUE_TO_SUBTRACT[f % VALUE_TO_SUBTRACT_SIZE]);
#elif defined MEAN_SUBTRACT_IN_BUFFER
#if defined MEAN_PER_FEATURE
 MEAN_SUBTRACT_TYPE res = TO_MEAN_TYPE(input[input_idx]);
 res = MEAN_OP(res, mean_subtract[f]);
#else
 MEAN_SUBTRACT_TYPE res = TO_MEAN_TYPE(input[input_idx]);
 uint8 msv = RESHAPE_DIMS(INPUT0, MEAN_SUBTRACT, b, f, v, u, w, z, y, x);
 res = MEAN_OP(res, mean_subtract[GET_DATA_INDEX_SAFE(MEAN_SUBTRACT, msv.s0, msv.s1, msv.s6, msv.s7)]);
#endif
#elif SURFACE_INPUT
 float4 Y = read_imagef(input, (int2)(x, y));
 float Ycomponent = mad(Y.x, 296.82f, -18.624f);
 float res = clamp(Ycomponent, 0.f, 255.f);
#else
 CALC_TYPE res = TO_CALC_TYPE(input[input_idx]);
#endif
#endif
#if defined INPUT0_LAYOUT_NV12 && !SURFACE_INPUT
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 0, v, u, w, z, y, x);
 uint output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(R), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 1, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(G), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 2, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(B), NL_M, NL_N);
#elif INPUT0_LAYOUT_IMAGE_2D_RGBA
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 0, v, u, w, z, y, x);
 uint output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s0), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 1, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s1), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 2, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s2), NL_M, NL_N);
#if INPUT0_FEATURE_NUM == 4
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 3, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s3), NL_M, NL_N);
#endif
#elif OUTPUT_LAYOUT_IMAGE_2D_RGBA
 IMAGE_WRITE(output, (int2)(x, y), colorRGBA);
#else
#if INPUT0_IS_FP && !OUTPUT_IS_FP
#if CONVERT_TRUNCATE
 output[output_idx] = ACTIVATION_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(convert_long(res)), ACTIVATION_PARAMS_TYPED);
#else
 output[output_idx] = ACTIVATION_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE_SAT(res), ACTIVATION_PARAMS_TYPED);
#endif
#else
 output[output_idx] = ACTIVATION_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(res), ACTIVATION_PARAMS_TYPED);
#endif
#endif
}
#undef INPUT_TYPE4
#undef OUTPUT_TYPE4
#ifdef INPUT_TYPE4
#undef INPUT_TYPE4
#endif
#ifdef OUTPUT_TYPE4
#undef OUTPUT_TYPE4
#endif
#ifdef RESHAPE_DIMS
#undef RESHAPE_DIMS
#endif
#ifdef DECLARE_SAMPLER
#undef DECLARE_SAMPLER
#endif
#ifdef IMAGE_READ
#undef IMAGE_READ
#endif
#ifdef IMAGE_WRITE
#undef IMAGE_WRITE
#endif
#ifdef IMAGE_READ
#undef IMAGE_READ
#endif
#ifdef IMAGE_WRITE
#undef IMAGE_WRITE
#endif
#undef KERNEL
#undef FUNC
#undef FUNC_CALL
#undef CONST_ARRAY_DECL
#undef CONST_ARRAY_REF
#ifdef FP64_SUPPORTED
#undef FP64_SUPPORTED
#endif
#ifdef FP16_SUPPORTED
#undef FP16_SUPPORTED
#endif
#ifdef FP16_UNIT_USED
#undef FP16_UNIT_USED
#endif
#ifdef INT8_UNIT_USED
#undef INT8_UNIT_USED
#endif
#ifdef INT32_UNIT_USED
#undef INT32_UNIT_USED
#endif
#ifdef INT64_UNIT_USED
#undef INT64_UNIT_USED
#endif
#ifdef UINT8_UNIT_USED
#undef UINT8_UNIT_USED
#endif
#ifdef UINT32_UNIT_USED
#undef UINT32_UNIT_USED
#endif
#ifdef UNIT_TYPE
#undef UNIT_TYPE
#endif
#ifdef UNIT_VAL_MAX
#undef UNIT_VAL_MAX
#endif
#ifdef UNIT_VAL_MIN
#undef UNIT_VAL_MIN
#endif
#ifdef UNIT_VAL_ONE
#undef UNIT_VAL_ONE
#endif
#ifdef UNIT_VAL_ZERO
#undef UNIT_VAL_ZERO
#endif
#ifdef TO_UNIT_TYPE
#undef TO_UNIT_TYPE
#endif
#ifdef TO_UNIT_TYPE_SAT
#undef TO_UNIT_TYPE_SAT
#endif
#ifdef AS_UNIT_TYPE
#undef AS_UNIT_TYPE
#endif
#ifdef UNIT_MAX_FUNC
#undef UNIT_MAX_FUNC
#endif
#ifdef UNIT_MIN_FUNC
#undef UNIT_MIN_FUNC
#endif
#ifdef UNIT_ABS_FUNC
#undef UNIT_ABS_FUNC
#endif
#ifdef UNIT_TYPE_SIZE
#undef UNIT_TYPE_SIZE
#endif
#ifdef UNIT_IS_FP
#undef UNIT_IS_FP
#endif
#ifdef NL_M
#undef NL_M
#endif
#ifdef NL_N
#undef NL_N
#endif
#ifdef ACTIVATION_FUNC_TYPE
#undef ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_VAL_MAX
#undef ACTIVATION_FUNC_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_VAL_MIN
#undef ACTIVATION_FUNC_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_VAL_ONE
#undef ACTIVATION_FUNC_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_VAL_ZERO
#undef ACTIVATION_FUNC_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE
#undef TO_ACTIVATION_FUNC_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPE
#undef AS_ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_MAX_FUNC
#undef ACTIVATION_FUNC_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_MIN_FUNC
#undef ACTIVATION_FUNC_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_ABS_FUNC
#undef ACTIVATION_FUNC_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_IS_FP
#undef ACTIVATION_FUNC_IS_FP
#endif
#ifdef ACTIVATION_PARAMS
#undef ACTIVATION_PARAMS
#endif
#ifdef ACTIVATION_FUNC
#undef ACTIVATION_FUNC
#endif
#ifdef ACTIVATION
#undef ACTIVATION
#endif
#ifdef INPUT0_SIZE_X
#undef INPUT0_SIZE_X
#endif
#ifdef INPUT0_SIZE_Y
#undef INPUT0_SIZE_Y
#endif
#ifdef INPUT0_SIZE_Z
#undef INPUT0_SIZE_Z
#endif
#ifdef INPUT0_SIZE_W
#undef INPUT0_SIZE_W
#endif
#ifdef INPUT0_SIZE_U
#undef INPUT0_SIZE_U
#endif
#ifdef INPUT0_SIZE_V
#undef INPUT0_SIZE_V
#endif
#ifdef INPUT0_FEATURE_NUM
#undef INPUT0_FEATURE_NUM
#endif
#ifdef INPUT0_BATCH_NUM
#undef INPUT0_BATCH_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_X
#undef INPUT0_PAD_BEFORE_SIZE_X
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Y
#undef INPUT0_PAD_BEFORE_SIZE_Y
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Z
#undef INPUT0_PAD_BEFORE_SIZE_Z
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_W
#undef INPUT0_PAD_BEFORE_SIZE_W
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_U
#undef INPUT0_PAD_BEFORE_SIZE_U
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_V
#undef INPUT0_PAD_BEFORE_SIZE_V
#endif
#ifdef INPUT0_PAD_BEFORE_FEATURE_NUM
#undef INPUT0_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_BATCH_NUM
#undef INPUT0_PAD_BEFORE_BATCH_NUM
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_X
#undef INPUT0_PAD_AFTER_SIZE_X
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Y
#undef INPUT0_PAD_AFTER_SIZE_Y
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Z
#undef INPUT0_PAD_AFTER_SIZE_Z
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_W
#undef INPUT0_PAD_AFTER_SIZE_W
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_U
#undef INPUT0_PAD_AFTER_SIZE_U
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_V
#undef INPUT0_PAD_AFTER_SIZE_V
#endif
#ifdef INPUT0_PAD_AFTER_FEATURE_NUM
#undef INPUT0_PAD_AFTER_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_AFTER_BATCH_NUM
#undef INPUT0_PAD_AFTER_BATCH_NUM
#endif
#ifdef INPUT0_X_PITCH
#undef INPUT0_X_PITCH
#endif
#ifdef INPUT0_Y_PITCH
#undef INPUT0_Y_PITCH
#endif
#ifdef INPUT0_Z_PITCH
#undef INPUT0_Z_PITCH
#endif
#ifdef INPUT0_W_PITCH
#undef INPUT0_W_PITCH
#endif
#ifdef INPUT0_U_PITCH
#undef INPUT0_U_PITCH
#endif
#ifdef INPUT0_V_PITCH
#undef INPUT0_V_PITCH
#endif
#ifdef INPUT0_FEATURE_PITCH
#undef INPUT0_FEATURE_PITCH
#endif
#ifdef INPUT0_BATCH_PITCH
#undef INPUT0_BATCH_PITCH
#endif
#ifdef INPUT0_GET_INDEX_SAFE
#undef INPUT0_GET_INDEX_SAFE
#endif
#ifdef INPUT0_GET_INDEX
#undef INPUT0_GET_INDEX
#endif
#ifdef INPUT0_GET_INDEX_RAW
#undef INPUT0_GET_INDEX_RAW
#endif
#ifdef INPUT0_VIEW_OFFSET
#undef INPUT0_VIEW_OFFSET
#endif
#ifdef INPUT0_LENGTH
#undef INPUT0_LENGTH
#endif
#ifdef INPUT0_DIMS
#undef INPUT0_DIMS
#endif
#ifdef INPUT0_SIMPLE
#undef INPUT0_SIMPLE
#endif
#ifdef INPUT0_GROUPED
#undef INPUT0_GROUPED
#endif
#ifdef INPUT0_LAYOUT_BFYX
#undef INPUT0_LAYOUT_BFYX
#endif
#ifdef INPUT0_TYPE
#undef INPUT0_TYPE
#endif
#ifdef INPUT0_VAL_MAX
#undef INPUT0_VAL_MAX
#endif
#ifdef INPUT0_VAL_MIN
#undef INPUT0_VAL_MIN
#endif
#ifdef INPUT0_VAL_ONE
#undef INPUT0_VAL_ONE
#endif
#ifdef INPUT0_VAL_ZERO
#undef INPUT0_VAL_ZERO
#endif
#ifdef TO_INPUT0_TYPE
#undef TO_INPUT0_TYPE
#endif
#ifdef TO_INPUT0_TYPE_SAT
#undef TO_INPUT0_TYPE_SAT
#endif
#ifdef AS_INPUT0_TYPE
#undef AS_INPUT0_TYPE
#endif
#ifdef INPUT0_MAX_FUNC
#undef INPUT0_MAX_FUNC
#endif
#ifdef INPUT0_MIN_FUNC
#undef INPUT0_MIN_FUNC
#endif
#ifdef INPUT0_ABS_FUNC
#undef INPUT0_ABS_FUNC
#endif
#ifdef INPUT0_TYPE_SIZE
#undef INPUT0_TYPE_SIZE
#endif
#ifdef INPUT0_IS_FP
#undef INPUT0_IS_FP
#endif
#ifdef INPUT0_OFFSET
#undef INPUT0_OFFSET
#endif
#ifdef INPUT0_SIZES_DATA
#undef INPUT0_SIZES_DATA
#endif
#ifdef INPUT0_PITCHES
#undef INPUT0_PITCHES
#endif
#ifdef INPUT0_PAD_BEFORE
#undef INPUT0_PAD_BEFORE
#endif
#ifdef INPUT0_PAD_AFTER
#undef INPUT0_PAD_AFTER
#endif
#ifdef OUTPUT_SIZE_X
#undef OUTPUT_SIZE_X
#endif
#ifdef OUTPUT_SIZE_Y
#undef OUTPUT_SIZE_Y
#endif
#ifdef OUTPUT_SIZE_Z
#undef OUTPUT_SIZE_Z
#endif
#ifdef OUTPUT_SIZE_W
#undef OUTPUT_SIZE_W
#endif
#ifdef OUTPUT_SIZE_U
#undef OUTPUT_SIZE_U
#endif
#ifdef OUTPUT_SIZE_V
#undef OUTPUT_SIZE_V
#endif
#ifdef OUTPUT_FEATURE_NUM
#undef OUTPUT_FEATURE_NUM
#endif
#ifdef OUTPUT_BATCH_NUM
#undef OUTPUT_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_X
#undef OUTPUT_PAD_BEFORE_SIZE_X
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Y
#undef OUTPUT_PAD_BEFORE_SIZE_Y
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Z
#undef OUTPUT_PAD_BEFORE_SIZE_Z
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_W
#undef OUTPUT_PAD_BEFORE_SIZE_W
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_U
#undef OUTPUT_PAD_BEFORE_SIZE_U
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_V
#undef OUTPUT_PAD_BEFORE_SIZE_V
#endif
#ifdef OUTPUT_PAD_BEFORE_FEATURE_NUM
#undef OUTPUT_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_BATCH_NUM
#undef OUTPUT_PAD_BEFORE_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_X
#undef OUTPUT_PAD_AFTER_SIZE_X
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Y
#undef OUTPUT_PAD_AFTER_SIZE_Y
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Z
#undef OUTPUT_PAD_AFTER_SIZE_Z
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_W
#undef OUTPUT_PAD_AFTER_SIZE_W
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_U
#undef OUTPUT_PAD_AFTER_SIZE_U
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_V
#undef OUTPUT_PAD_AFTER_SIZE_V
#endif
#ifdef OUTPUT_PAD_AFTER_FEATURE_NUM
#undef OUTPUT_PAD_AFTER_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_BATCH_NUM
#undef OUTPUT_PAD_AFTER_BATCH_NUM
#endif
#ifdef OUTPUT_X_PITCH
#undef OUTPUT_X_PITCH
#endif
#ifdef OUTPUT_Y_PITCH
#undef OUTPUT_Y_PITCH
#endif
#ifdef OUTPUT_Z_PITCH
#undef OUTPUT_Z_PITCH
#endif
#ifdef OUTPUT_W_PITCH
#undef OUTPUT_W_PITCH
#endif
#ifdef OUTPUT_U_PITCH
#undef OUTPUT_U_PITCH
#endif
#ifdef OUTPUT_V_PITCH
#undef OUTPUT_V_PITCH
#endif
#ifdef OUTPUT_FEATURE_PITCH
#undef OUTPUT_FEATURE_PITCH
#endif
#ifdef OUTPUT_BATCH_PITCH
#undef OUTPUT_BATCH_PITCH
#endif
#ifdef OUTPUT_GET_INDEX_SAFE
#undef OUTPUT_GET_INDEX_SAFE
#endif
#ifdef OUTPUT_GET_INDEX
#undef OUTPUT_GET_INDEX
#endif
#ifdef OUTPUT_GET_INDEX_RAW
#undef OUTPUT_GET_INDEX_RAW
#endif
#ifdef OUTPUT_VIEW_OFFSET
#undef OUTPUT_VIEW_OFFSET
#endif
#ifdef OUTPUT_LENGTH
#undef OUTPUT_LENGTH
#endif
#ifdef OUTPUT_DIMS
#undef OUTPUT_DIMS
#endif
#ifdef OUTPUT_SIMPLE
#undef OUTPUT_SIMPLE
#endif
#ifdef OUTPUT_GROUPED
#undef OUTPUT_GROUPED
#endif
#ifdef OUTPUT_LAYOUT_BFYX
#undef OUTPUT_LAYOUT_BFYX
#endif
#ifdef OUTPUT_TYPE
#undef OUTPUT_TYPE
#endif
#ifdef OUTPUT_VAL_MAX
#undef OUTPUT_VAL_MAX
#endif
#ifdef OUTPUT_VAL_MIN
#undef OUTPUT_VAL_MIN
#endif
#ifdef OUTPUT_VAL_ONE
#undef OUTPUT_VAL_ONE
#endif
#ifdef OUTPUT_VAL_ZERO
#undef OUTPUT_VAL_ZERO
#endif
#ifdef TO_OUTPUT_TYPE
#undef TO_OUTPUT_TYPE
#endif
#ifdef TO_OUTPUT_TYPE_SAT
#undef TO_OUTPUT_TYPE_SAT
#endif
#ifdef AS_OUTPUT_TYPE
#undef AS_OUTPUT_TYPE
#endif
#ifdef OUTPUT_MAX_FUNC
#undef OUTPUT_MAX_FUNC
#endif
#ifdef OUTPUT_MIN_FUNC
#undef OUTPUT_MIN_FUNC
#endif
#ifdef OUTPUT_ABS_FUNC
#undef OUTPUT_ABS_FUNC
#endif
#ifdef OUTPUT_TYPE_SIZE
#undef OUTPUT_TYPE_SIZE
#endif
#ifdef OUTPUT_IS_FP
#undef OUTPUT_IS_FP
#endif
#ifdef OUTPUT_OFFSET
#undef OUTPUT_OFFSET
#endif
#ifdef OUTPUT_SIZES_DATA
#undef OUTPUT_SIZES_DATA
#endif
#ifdef OUTPUT_PITCHES
#undef OUTPUT_PITCHES
#endif
#ifdef OUTPUT_PAD_BEFORE
#undef OUTPUT_PAD_BEFORE
#endif
#ifdef OUTPUT_PAD_AFTER
#undef OUTPUT_PAD_AFTER
#endif
#ifdef OPTIONAL_SHAPE_INFO_ARG
#undef OPTIONAL_SHAPE_INFO_ARG
#endif
#ifdef OPTIONAL_SHAPE_INFO_TENSOR
#undef OPTIONAL_SHAPE_INFO_TENSOR
#endif
#ifdef MEAN_SUBTRACT_NONE
#undef MEAN_SUBTRACT_NONE
#endif
#ifdef CALC_TYPE
#undef CALC_TYPE
#endif
#ifdef CALC_VAL_MAX
#undef CALC_VAL_MAX
#endif
#ifdef CALC_VAL_MIN
#undef CALC_VAL_MIN
#endif
#ifdef CALC_VAL_ONE
#undef CALC_VAL_ONE
#endif
#ifdef CALC_VAL_ZERO
#undef CALC_VAL_ZERO
#endif
#ifdef TO_CALC_TYPE
#undef TO_CALC_TYPE
#endif
#ifdef TO_CALC_TYPE_SAT
#undef TO_CALC_TYPE_SAT
#endif
#ifdef AS_CALC_TYPE
#undef AS_CALC_TYPE
#endif
#ifdef CALC_MAX_FUNC
#undef CALC_MAX_FUNC
#endif
#ifdef CALC_MIN_FUNC
#undef CALC_MIN_FUNC
#endif
#ifdef CALC_ABS_FUNC
#undef CALC_ABS_FUNC
#endif
#ifdef CALC_TYPE_SIZE
#undef CALC_TYPE_SIZE
#endif
#ifdef CALC_IS_FP
#undef CALC_IS_FP
#endif
#ifdef INPUT_REORDER_TYPE
#undef INPUT_REORDER_TYPE
#endif
#ifdef INPUT_REORDER_VAL_MAX
#undef INPUT_REORDER_VAL_MAX
#endif
#ifdef INPUT_REORDER_VAL_MIN
#undef INPUT_REORDER_VAL_MIN
#endif
#ifdef INPUT_REORDER_VAL_ONE
#undef INPUT_REORDER_VAL_ONE
#endif
#ifdef INPUT_REORDER_VAL_ZERO
#undef INPUT_REORDER_VAL_ZERO
#endif
#ifdef TO_INPUT_REORDER_TYPE
#undef TO_INPUT_REORDER_TYPE
#endif
#ifdef TO_INPUT_REORDER_TYPE_SAT
#undef TO_INPUT_REORDER_TYPE_SAT
#endif
#ifdef AS_INPUT_REORDER_TYPE
#undef AS_INPUT_REORDER_TYPE
#endif
#ifdef INPUT_REORDER_MAX_FUNC
#undef INPUT_REORDER_MAX_FUNC
#endif
#ifdef INPUT_REORDER_MIN_FUNC
#undef INPUT_REORDER_MIN_FUNC
#endif
#ifdef INPUT_REORDER_ABS_FUNC
#undef INPUT_REORDER_ABS_FUNC
#endif
#ifdef INPUT_REORDER_TYPE_SIZE
#undef INPUT_REORDER_TYPE_SIZE
#endif
#ifdef INPUT_REORDER_IS_FP
#undef INPUT_REORDER_IS_FP
#endif
#ifdef OUTPUT_REORDER_TYPE
#undef OUTPUT_REORDER_TYPE
#endif
#ifdef OUTPUT_REORDER_VAL_MAX
#undef OUTPUT_REORDER_VAL_MAX
#endif
#ifdef OUTPUT_REORDER_VAL_MIN
#undef OUTPUT_REORDER_VAL_MIN
#endif
#ifdef OUTPUT_REORDER_VAL_ONE
#undef OUTPUT_REORDER_VAL_ONE
#endif
#ifdef OUTPUT_REORDER_VAL_ZERO
#undef OUTPUT_REORDER_VAL_ZERO
#endif
#ifdef TO_OUTPUT_REORDER_TYPE
#undef TO_OUTPUT_REORDER_TYPE
#endif
#ifdef TO_OUTPUT_REORDER_TYPE_SAT
#undef TO_OUTPUT_REORDER_TYPE_SAT
#endif
#ifdef AS_OUTPUT_REORDER_TYPE
#undef AS_OUTPUT_REORDER_TYPE
#endif
#ifdef OUTPUT_REORDER_MAX_FUNC
#undef OUTPUT_REORDER_MAX_FUNC
#endif
#ifdef OUTPUT_REORDER_MIN_FUNC
#undef OUTPUT_REORDER_MIN_FUNC
#endif
#ifdef OUTPUT_REORDER_ABS_FUNC
#undef OUTPUT_REORDER_ABS_FUNC
#endif
#ifdef OUTPUT_REORDER_TYPE_SIZE
#undef OUTPUT_REORDER_TYPE_SIZE
#endif
#ifdef OUTPUT_REORDER_IS_FP
#undef OUTPUT_REORDER_IS_FP
#endif
#ifdef MEAN_OP
#undef MEAN_OP
#endif
#ifdef NL_M_TYPED
#undef NL_M_TYPED
#endif
#ifdef NL_N_TYPED
#undef NL_N_TYPED
#endif
#ifdef ACTIVATION_FUNC_TYPED_TYPE
#undef ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_MAX
#undef ACTIVATION_FUNC_TYPED_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_MIN
#undef ACTIVATION_FUNC_TYPED_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_ONE
#undef ACTIVATION_FUNC_TYPED_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_ZERO
#undef ACTIVATION_FUNC_TYPED_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_TYPE
#undef TO_ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPED_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPED_TYPE
#undef AS_ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_MAX_FUNC
#undef ACTIVATION_FUNC_TYPED_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_MIN_FUNC
#undef ACTIVATION_FUNC_TYPED_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_ABS_FUNC
#undef ACTIVATION_FUNC_TYPED_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPED_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_TYPED_IS_FP
#undef ACTIVATION_FUNC_TYPED_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_TYPED
#undef ACTIVATION_PARAMS_TYPED
#endif
#ifdef ACTIVATION_FUNC_TYPED
#undef ACTIVATION_FUNC_TYPED
#endif
#ifdef ACTIVATION_TYPED
#undef ACTIVATION_TYPED
#endif
#ifdef SUB_GROUP_SIZE
#undef SUB_GROUP_SIZE
#endif
#ifdef CONVERT_TRUNCATE
#undef CONVERT_TRUNCATE
#endif
#ifdef GWS_BATCH
#undef GWS_BATCH
#endif
#ifdef GWS_FEATURE
#undef GWS_FEATURE
#endif
#ifdef GWS_YX
#undef GWS_YX
#endif

//====================================================
// Kernel template: fully_connected_gpu_bf_tiled 
// Kernel name: fully_connected_gpu_bf_tiled_18033239253677070461_0
#define KERNEL(name) __kernel void fully_connected_gpu_bf_tiled_18033239253677070461_0
#define FUNC(name)  _##name##_fully_connected_gpu_bf_tiled_18033239253677070461_0
#define FUNC_CALL(name)  _##name##_fully_connected_gpu_bf_tiled_18033239253677070461_0
#define CONST_ARRAY_DECL(name) __constant size_t  _##name##_fully_connected_gpu_bf_tiled_18033239253677070461_0 []
#define CONST_ARRAY_REF(name)  _##name##_fully_connected_gpu_bf_tiled_18033239253677070461_0
#define FP64_SUPPORTED 0
#define FP16_SUPPORTED 1
#define FP16_UNIT_USED 1
#define INT8_UNIT_USED 0
#define INT32_UNIT_USED 0
#define INT64_UNIT_USED 0
#define UINT8_UNIT_USED 0
#define UINT32_UNIT_USED 0
#define UNIT_TYPE half
#define UNIT_VAL_MAX HALF_MAX
#define UNIT_VAL_MIN -UNIT_VAL_MAX
#define UNIT_VAL_ONE 1.0h
#define UNIT_VAL_ZERO 0.0h
#define TO_UNIT_TYPE(v) convert_half(v)
#define TO_UNIT_TYPE_SAT(v) convert_half(v)
#define AS_UNIT_TYPE(v) as_half(v)
#define UNIT_MAX_FUNC fmax
#define UNIT_MIN_FUNC fmin
#define UNIT_ABS_FUNC fabs
#define UNIT_TYPE_SIZE 2
#define UNIT_IS_FP 1
#define NL_M as_float(0x0)/*0.000000e+00*/
#define NL_N as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPE half
#define ACTIVATION_FUNC_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_VAL_MIN -ACTIVATION_FUNC_VAL_MAX
#define ACTIVATION_FUNC_VAL_ONE 1.0h
#define ACTIVATION_FUNC_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_MAX_FUNC fmax
#define ACTIVATION_FUNC_MIN_FUNC fmin
#define ACTIVATION_FUNC_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPE_SIZE 2
#define ACTIVATION_FUNC_IS_FP 1
#define ACTIVATION_PARAMS NL_M, NL_N
#define ACTIVATION_FUNC(input, m, n) input
#define ACTIVATION(input, params) ACTIVATION_FUNC(input, params)
#define INPUT0_SIZE_X 1
#define INPUT0_SIZE_Y 1
#define INPUT0_SIZE_Z 1
#define INPUT0_SIZE_W 1
#define INPUT0_SIZE_U 1
#define INPUT0_SIZE_V 1
#define INPUT0_FEATURE_NUM 512
#define INPUT0_BATCH_NUM 10
#define INPUT0_PAD_BEFORE_SIZE_X 0
#define INPUT0_PAD_BEFORE_SIZE_Y 0
#define INPUT0_PAD_BEFORE_SIZE_Z 0
#define INPUT0_PAD_BEFORE_SIZE_W 0
#define INPUT0_PAD_BEFORE_SIZE_U 0
#define INPUT0_PAD_BEFORE_SIZE_V 0
#define INPUT0_PAD_BEFORE_FEATURE_NUM 0
#define INPUT0_PAD_BEFORE_BATCH_NUM 0
#define INPUT0_PAD_AFTER_SIZE_X 0
#define INPUT0_PAD_AFTER_SIZE_Y 0
#define INPUT0_PAD_AFTER_SIZE_Z 0
#define INPUT0_PAD_AFTER_SIZE_W 0
#define INPUT0_PAD_AFTER_SIZE_U 0
#define INPUT0_PAD_AFTER_SIZE_V 0
#define INPUT0_PAD_AFTER_FEATURE_NUM 0
#define INPUT0_PAD_AFTER_BATCH_NUM 0
#define INPUT0_X_PITCH 1
#define INPUT0_Y_PITCH 1
#define INPUT0_Z_PITCH 1
#define INPUT0_W_PITCH 1
#define INPUT0_U_PITCH 1
#define INPUT0_V_PITCH 1
#define INPUT0_FEATURE_PITCH 1
#define INPUT0_BATCH_PITCH 512
#define INPUT0_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX(b, f, y, x) GET_DATA_INDEX(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(INPUT0, b, f, y, x)
#define INPUT0_VIEW_OFFSET 0
#define INPUT0_LENGTH 5120
#define INPUT0_DIMS 4
#define INPUT0_SIMPLE 1
#define INPUT0_GROUPED 0
#define INPUT0_LAYOUT_BFYX 1
#define INPUT0_TYPE half
#define INPUT0_VAL_MAX HALF_MAX
#define INPUT0_VAL_MIN -INPUT0_VAL_MAX
#define INPUT0_VAL_ONE 1.0h
#define INPUT0_VAL_ZERO 0.0h
#define TO_INPUT0_TYPE(v) convert_half(v)
#define TO_INPUT0_TYPE_SAT(v) convert_half(v)
#define AS_INPUT0_TYPE(v) as_half(v)
#define INPUT0_MAX_FUNC fmax
#define INPUT0_MIN_FUNC fmin
#define INPUT0_ABS_FUNC fabs
#define INPUT0_TYPE_SIZE 2
#define INPUT0_IS_FP 1
#define INPUT0_OFFSET 0
#define INPUT0_SIZES_DATA { 1,1,512,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(INPUT0_SIZES) = INPUT0_SIZES_DATA;
#define INPUT0_SIZES CONST_ARRAY_REF(INPUT0_SIZES)
#define INPUT0_PITCHES (size_t []){ 1,1,1,512,1,1,1,1,1, } 
#define INPUT0_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define INPUT0_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_SIZE_X 1
#define OUTPUT_SIZE_Y 1
#define OUTPUT_SIZE_Z 1
#define OUTPUT_SIZE_W 1
#define OUTPUT_SIZE_U 1
#define OUTPUT_SIZE_V 1
#define OUTPUT_FEATURE_NUM 128
#define OUTPUT_BATCH_NUM 10
#define OUTPUT_PAD_BEFORE_SIZE_X 0
#define OUTPUT_PAD_BEFORE_SIZE_Y 0
#define OUTPUT_PAD_BEFORE_SIZE_Z 0
#define OUTPUT_PAD_BEFORE_SIZE_W 0
#define OUTPUT_PAD_BEFORE_SIZE_U 0
#define OUTPUT_PAD_BEFORE_SIZE_V 0
#define OUTPUT_PAD_BEFORE_FEATURE_NUM 0
#define OUTPUT_PAD_BEFORE_BATCH_NUM 0
#define OUTPUT_PAD_AFTER_SIZE_X 0
#define OUTPUT_PAD_AFTER_SIZE_Y 0
#define OUTPUT_PAD_AFTER_SIZE_Z 0
#define OUTPUT_PAD_AFTER_SIZE_W 0
#define OUTPUT_PAD_AFTER_SIZE_U 0
#define OUTPUT_PAD_AFTER_SIZE_V 0
#define OUTPUT_PAD_AFTER_FEATURE_NUM 0
#define OUTPUT_PAD_AFTER_BATCH_NUM 0
#define OUTPUT_X_PITCH 1
#define OUTPUT_Y_PITCH 1
#define OUTPUT_Z_PITCH 1
#define OUTPUT_W_PITCH 1
#define OUTPUT_U_PITCH 1
#define OUTPUT_V_PITCH 1
#define OUTPUT_FEATURE_PITCH 1
#define OUTPUT_BATCH_PITCH 128
#define OUTPUT_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX(b, f, y, x) GET_DATA_INDEX(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(OUTPUT, b, f, y, x)
#define OUTPUT_VIEW_OFFSET 0
#define OUTPUT_LENGTH 1280
#define OUTPUT_DIMS 2
#define OUTPUT_SIMPLE 1
#define OUTPUT_GROUPED 0
#define OUTPUT_LAYOUT_BF 1
#define OUTPUT_TYPE half
#define OUTPUT_VAL_MAX HALF_MAX
#define OUTPUT_VAL_MIN -OUTPUT_VAL_MAX
#define OUTPUT_VAL_ONE 1.0h
#define OUTPUT_VAL_ZERO 0.0h
#define TO_OUTPUT_TYPE(v) convert_half(v)
#define TO_OUTPUT_TYPE_SAT(v) convert_half(v)
#define AS_OUTPUT_TYPE(v) as_half(v)
#define OUTPUT_MAX_FUNC fmax
#define OUTPUT_MIN_FUNC fmin
#define OUTPUT_ABS_FUNC fabs
#define OUTPUT_TYPE_SIZE 2
#define OUTPUT_IS_FP 1
#define OUTPUT_OFFSET 0
#define OUTPUT_SIZES_DATA { 128,10,1,1,1,1,1,1,1, } 
CONST_ARRAY_DECL(OUTPUT_SIZES) = OUTPUT_SIZES_DATA;
#define OUTPUT_SIZES CONST_ARRAY_REF(OUTPUT_SIZES)
#define OUTPUT_PITCHES (size_t []){ 1,128,1,1,1,1,1,1,1, } 
#define OUTPUT_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OPTIONAL_SHAPE_INFO_ARG 
#define OPTIONAL_SHAPE_INFO_TENSOR 
#define FILTER_SIZE_X 1
#define FILTER_SIZE_Y 1
#define FILTER_SIZE_Z 1
#define FILTER_IFM_NUM 512
#define FILTER_OFM_NUM 128
#define FILTER_GROUPS_NUM 1
#define FILTER_X_PITCH 1
#define FILTER_Y_PITCH 1
#define FILTER_Z_PITCH 1
#define FILTER_IFM_PITCH 1
#define FILTER_OFM_PITCH 512
#define FILTER_GROUPS_PITCH 1
#define FILTER_VIEW_OFFSET 0
#define FILTER_LENGTH 65536
#define FILTER_DIMS 4
#define FILTER_SIMPLE 0
#define FILTER_GROUPED 0
#define FILTER_LAYOUT_OS_IYX_OSV32 1
#define FILTER_TYPE half
#define FILTER_VAL_MAX HALF_MAX
#define FILTER_VAL_MIN -FILTER_VAL_MAX
#define FILTER_VAL_ONE 1.0h
#define FILTER_VAL_ZERO 0.0h
#define TO_FILTER_TYPE(v) convert_half(v)
#define TO_FILTER_TYPE_SAT(v) convert_half(v)
#define AS_FILTER_TYPE(v) as_half(v)
#define FILTER_MAX_FUNC fmax
#define FILTER_MIN_FUNC fmin
#define FILTER_ABS_FUNC fabs
#define FILTER_TYPE_SIZE 2
#define FILTER_IS_FP 1
#define FILTER_OFFSET 0
#define FILTER_SIZES_DATA { 1,1,512,128,1,1,1,1,1, } 
CONST_ARRAY_DECL(FILTER_SIZES) = FILTER_SIZES_DATA;
#define FILTER_SIZES CONST_ARRAY_REF(FILTER_SIZES)
#define FILTER_PITCHES (size_t []){ 1,1,1,512,1,1,1,1,1, } 
#define FILTER_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define FILTER_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_TERM 1
#define BIAS_SIZE_X 1
#define BIAS_SIZE_Y 1
#define BIAS_SIZE_Z 1
#define BIAS_SIZE_W 1
#define BIAS_SIZE_U 1
#define BIAS_SIZE_V 1
#define BIAS_FEATURE_NUM 128
#define BIAS_BATCH_NUM 1
#define BIAS_PAD_BEFORE_SIZE_X 0
#define BIAS_PAD_BEFORE_SIZE_Y 0
#define BIAS_PAD_BEFORE_SIZE_Z 0
#define BIAS_PAD_BEFORE_SIZE_W 0
#define BIAS_PAD_BEFORE_SIZE_U 0
#define BIAS_PAD_BEFORE_SIZE_V 0
#define BIAS_PAD_BEFORE_FEATURE_NUM 0
#define BIAS_PAD_BEFORE_BATCH_NUM 0
#define BIAS_PAD_AFTER_SIZE_X 0
#define BIAS_PAD_AFTER_SIZE_Y 0
#define BIAS_PAD_AFTER_SIZE_Z 0
#define BIAS_PAD_AFTER_SIZE_W 0
#define BIAS_PAD_AFTER_SIZE_U 0
#define BIAS_PAD_AFTER_SIZE_V 0
#define BIAS_PAD_AFTER_FEATURE_NUM 0
#define BIAS_PAD_AFTER_BATCH_NUM 0
#define BIAS_X_PITCH 1
#define BIAS_Y_PITCH 1
#define BIAS_Z_PITCH 1
#define BIAS_W_PITCH 1
#define BIAS_U_PITCH 1
#define BIAS_V_PITCH 1
#define BIAS_FEATURE_PITCH 1
#define BIAS_BATCH_PITCH 128
#define BIAS_GET_INDEX_SAFE(b, f, y, x) ((0 + (f)) % 128)
#define BIAS_GET_INDEX(b, f, y, x) (0 + (f))
#define BIAS_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(BIAS, b, f, y, x)
#define BIAS_VIEW_OFFSET 0
#define BIAS_LENGTH 128
#define BIAS_DIMS 2
#define BIAS_SIMPLE 1
#define BIAS_GROUPED 0
#define BIAS_LAYOUT_BF 1
#define BIAS_TYPE half
#define BIAS_VAL_MAX HALF_MAX
#define BIAS_VAL_MIN -BIAS_VAL_MAX
#define BIAS_VAL_ONE 1.0h
#define BIAS_VAL_ZERO 0.0h
#define TO_BIAS_TYPE(v) convert_half(v)
#define TO_BIAS_TYPE_SAT(v) convert_half(v)
#define AS_BIAS_TYPE(v) as_half(v)
#define BIAS_MAX_FUNC fmax
#define BIAS_MIN_FUNC fmin
#define BIAS_ABS_FUNC fabs
#define BIAS_TYPE_SIZE 2
#define BIAS_IS_FP 1
#define BIAS_OFFSET 0
#define BIAS_SIZES_DATA { 128,1,1,1,1,1,1,1,1, } 
CONST_ARRAY_DECL(BIAS_SIZES) = BIAS_SIZES_DATA;
#define BIAS_SIZES CONST_ARRAY_REF(BIAS_SIZES)
#define BIAS_PITCHES (size_t []){ 1,128,1,1,1,1,1,1,1, } 
#define BIAS_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_PER_OUTPUT 0
#define BIAS_PER_OFM 1
#define INPUT0_ELEMENTS_COUNT 512
#define SIMD 16
#define TILE_B 5
#define TILE_OFM 2
#define TILE_IFM 1
#define TILE_K 2
#define TILE_K_OFM 4
#define DISPATCH_BSV 2
#define DISPATCH_FSV 1
#define CONST_LOOP_CALL(macro, idx) macro(idx)
#define CONST_LOOP_1(macro) CONST_LOOP_CALL(macro, 0)
#define CONST_LOOP_2(macro) CONST_LOOP_1(macro); CONST_LOOP_CALL(macro,1)
#define CONST_LOOP_3(macro) CONST_LOOP_2(macro); CONST_LOOP_CALL(macro,2)
#define CONST_LOOP_4(macro) CONST_LOOP_3(macro); CONST_LOOP_CALL(macro,3)
#define CONST_LOOP_5(macro) CONST_LOOP_4(macro); CONST_LOOP_CALL(macro,4)
#define CONST_LOOP(count, macro) CAT(CONST_LOOP_, count)(macro)
#define REALIGN_FP16_OFFSET 0
#define ACTIVATION_TYPE half
#define ACTIVATION_VAL_MAX HALF_MAX
#define ACTIVATION_VAL_MIN -ACTIVATION_VAL_MAX
#define ACTIVATION_VAL_ONE 1.0h
#define ACTIVATION_VAL_ZERO 0.0h
#define TO_ACTIVATION_TYPE(v) convert_half(v)
#define TO_ACTIVATION_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_TYPE(v) as_half(v)
#define ACTIVATION_MAX_FUNC fmax
#define ACTIVATION_MIN_FUNC fmin
#define ACTIVATION_ABS_FUNC fabs
#define ACTIVATION_TYPE_SIZE 2
#define ACTIVATION_IS_FP 1
#define NL_M_TYPED as_float(0x0)/*0.000000e+00*/
#define NL_N_TYPED as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPED_TYPE half
#define ACTIVATION_FUNC_TYPED_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_TYPED_VAL_MIN -ACTIVATION_FUNC_TYPED_VAL_MAX
#define ACTIVATION_FUNC_TYPED_VAL_ONE 1.0h
#define ACTIVATION_FUNC_TYPED_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPED_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPED_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPED_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_TYPED_MAX_FUNC fmax
#define ACTIVATION_FUNC_TYPED_MIN_FUNC fmin
#define ACTIVATION_FUNC_TYPED_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPED_TYPE_SIZE 2
#define ACTIVATION_FUNC_TYPED_IS_FP 1
#define ACTIVATION_PARAMS_TYPED NL_M_TYPED, NL_N_TYPED
#define ACTIVATION_FUNC_TYPED(input, m, n) input
#define ACTIVATION_TYPED(input, params) ACTIVATION_FUNC_TYPED(input, params)
#define ACCUMULATOR_TYPE half
#define ACCUMULATOR_VAL_MAX HALF_MAX
#define ACCUMULATOR_VAL_MIN -ACCUMULATOR_VAL_MAX
#define ACCUMULATOR_VAL_ONE 1.0h
#define ACCUMULATOR_VAL_ZERO 0.0h
#define TO_ACCUMULATOR_TYPE(v) convert_half(v)
#define TO_ACCUMULATOR_TYPE_SAT(v) convert_half(v)
#define AS_ACCUMULATOR_TYPE(v) as_half(v)
#define ACCUMULATOR_MAX_FUNC fmax
#define ACCUMULATOR_MIN_FUNC fmin
#define ACCUMULATOR_ABS_FUNC fabs
#define ACCUMULATOR_TYPE_SIZE 2
#define ACCUMULATOR_IS_FP 1
#define TILE_OUT_F_NUM 128
#define TILE_OUT_F_PITCH 1
#define TILE_IN_B_PITCH 512
#define TILE_OUT_B_PITCH 128
#define BATCH_SIZE (OUTPUT_BATCH_NUM)


#if SIMD != 8 && SIMD != 16
# error "fully_connected_gpu_bf_tiled.cl - SIMD must be one of {8, 16}"
#endif
#if TILE_OFM != 1 && TILE_OFM != 2 && TILE_OFM != 4 && TILE_OFM != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_OFM must be one of {1, 2, 4, 8}"
#endif
#if TILE_IFM != 1 && TILE_IFM != 2 && TILE_IFM != 4 && TILE_IFM != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_IFM must be one of {1, 2, 4, 8}"
#endif
#if TILE_K != 1 && TILE_K != 2 && TILE_K != 4 && TILE_K != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_K must be one of {1, 2, 4, 8}"
#endif
#if TILE_K_OFM != (TILE_K * TILE_OFM) || TILE_K_OFM > 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_K_OFM must be equal to TILE_K * TILE_OFM and at most 8"
#endif
#define INPUT_VEC_TYPE MAKE_VECTOR_TYPE(INPUT0_TYPE, TILE_IFM)
#define ACCUMULATOR_VEC_TYPE MAKE_VECTOR_TYPE(ACCUMULATOR_TYPE, TILE_OFM)
#define FILTER_VEC_TYPE MAKE_VECTOR_TYPE(FILTER_TYPE, TILE_K_OFM)
#define BIAS_VEC_TYPE MAKE_VECTOR_TYPE(BIAS_TYPE, TILE_OFM)
#define OUTPUT_VEC_TYPE MAKE_VECTOR_TYPE(OUTPUT_TYPE, TILE_OFM)
#define ACTIVATION_VEC_TYPE MAKE_VECTOR_TYPE(ACTIVATION_TYPE, TILE_OFM)
#define TO_OUTPUT_VEC_TYPE(x) CAT(convert_, OUTPUT_VEC_TYPE)(x)
#define TO_ACTIVATION_VEC_TYPE(x) CAT(convert_, ACTIVATION_VEC_TYPE)(x)
#define INPUT_BLOCK_READ(ptr, offset) BLOCK_READN(INPUT0_TYPE, TILE_IFM, ptr, offset)
#define FILTER_BLOCK_READ(ptr, offset) BLOCK_READN(FILTER_TYPE, TILE_K_OFM, ptr, offset)
#define BIAS_BLOCK_READ(ptr, offset) BLOCK_READN(BIAS_TYPE, TILE_OFM, ptr, offset)
#define OUTPUT_BLOCK_WRITE(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, TILE_OFM, ptr, offset, val)
#define USE_BLOCK_WRITE ((OUTPUT_TYPE_SIZE * TILE_OUT_B_PITCH) % 16 == 0 && (OUTPUT_TYPE_SIZE * OUTPUT_OFFSET) % 16 == 0)
#if !REALIGN_FP16_OFFSET
# if OUTPUT_3D
# define MAIN_LOOP_ELEMENTS_COUNT INPUT0_SIZE_Y
# else
# define MAIN_LOOP_ELEMENTS_COUNT INPUT0_ELEMENTS_COUNT
# endif
#else
# if OUTPUT_3D
# define MAIN_LOOP_ELEMENTS_COUNT (INPUT0_SIZE_Y - 1)
# else
# define MAIN_LOOP_ELEMENTS_COUNT (INPUT0_ELEMENTS_COUNT - 1)
# endif
#endif
#if OUTPUT_3D
# define INPUT_ELEMENTS_COUNT INPUT0_SIZE_Y
#else
# define INPUT_ELEMENTS_COUNT INPUT0_ELEMENTS_COUNT
#endif
REQD_SUB_GROUP_SIZE(SIMD)
KERNEL(fc)(
 OPTIONAL_SHAPE_INFO_ARG
 const __global INPUT0_TYPE* input,
 __global OUTPUT_TYPE* output,
 const __global FILTER_TYPE* weights
#if BIAS_TERM
 , const __global BIAS_TYPE* biases
#endif
#if HAS_FUSED_OPS_DECLS
 , FUSED_OPS_DECLS
#endif
) {
 uint gid = (uint)get_group_id(0);
 uint sglid = (uint)get_sub_group_local_id();
 uint feature_mini_block = gid % DISPATCH_FSV;
 uint batch_mini_block = gid / DISPATCH_FSV % DISPATCH_BSV;
 uint feature_mega_block = gid / (DISPATCH_FSV * DISPATCH_BSV) % (CEIL_DIV(TILE_OUT_F_NUM, TILE_OFM * SIMD) / DISPATCH_FSV);
 uint batch_mega_block = gid / (DISPATCH_FSV * DISPATCH_BSV * CEIL_DIV(TILE_OUT_F_NUM, TILE_OFM * SIMD) / DISPATCH_FSV);
 uint out_f = (feature_mega_block * DISPATCH_FSV + feature_mini_block) * (TILE_OFM * SIMD);
 uint out_b = ((batch_mega_block * DISPATCH_BSV + batch_mini_block) * TILE_B);
 ACCUMULATOR_VEC_TYPE acc[TILE_B] = { };
 INPUT_VEC_TYPE in_0[TILE_B] = { };
 FILTER_VEC_TYPE wei = 0;
 uint input_offset = out_b * TILE_IN_B_PITCH + INPUT0_OFFSET;
 uint weights_offset = out_f * INPUT_ELEMENTS_COUNT;
#if REALIGN_FP16_OFFSET
 {
 INPUT0_TYPE tmp_input = input[input_offset + get_sub_group_local_id() % TILE_B * TILE_IN_B_PITCH];
 MAKE_VECTOR_TYPE(FILTER_TYPE, TILE_OFM) tmp_wei = BLOCK_READN(FILTER_TYPE, TILE_OFM, weights, weights_offset);
 unroll_for(uint bi = 0; bi < TILE_B; ++bi) {
 acc[bi] = _sub_group_shuffle(tmp_input, bi) * tmp_wei;
 }
 weights_offset += TILE_OFM * SIMD;
 input_offset += 1;
 }
#endif
 uint iterations = MAIN_LOOP_ELEMENTS_COUNT / (TILE_IFM * SIMD);
 __attribute__((opencl_unroll_hint(1)))
 for (uint ni = 0; ni < iterations; ++ni) {
 #define LOAD_IN_0(bi) do { in_0[bi] = INPUT_BLOCK_READ(input, input_offset); input_offset += TILE_IN_B_PITCH; } while (false)
 CONST_LOOP(TILE_B, LOAD_IN_0);
 #undef LOAD_IN_0
 input_offset += TILE_IFM * SIMD - TILE_IN_B_PITCH * TILE_B;
 unroll_for(uint ki = 0; ki < (TILE_IFM * SIMD) / TILE_K; ++ki) {
 wei = FILTER_BLOCK_READ(weights, weights_offset);
 weights_offset += TILE_K_OFM * SIMD;
 unroll_for (uint kii = 0; kii < TILE_K; ++kii) {
 const uint total_k = ki * TILE_K + kii;
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 INPUT0_TYPE in_val = _sub_group_shuffle(((INPUT0_TYPE*)(&in_0[bi]))[total_k / SIMD], total_k % SIMD);
 unroll_for (uint fi = 0; fi < TILE_OFM; ++fi) {
 ((ACCUMULATOR_TYPE*)(&acc[bi]))[fi] += in_val * ((FILTER_TYPE*)(&wei))[kii * TILE_OFM + fi];
 }
 }
 }
 }
 }
#if MAIN_LOOP_ELEMENTS_COUNT % (TILE_IFM * SIMD) != 0
 #define LEFTOVER_IFM (MAIN_LOOP_ELEMENTS_COUNT % (TILE_IFM * SIMD))
 {
 #define LOAD_IN_0(bi) do { in_0[bi] = INPUT_BLOCK_READ(input, input_offset); input_offset += TILE_IN_B_PITCH; } while (false)
 CONST_LOOP(TILE_B, LOAD_IN_0);
 #undef LOAD_IN_0
 input_offset += TILE_IFM * SIMD - TILE_IN_B_PITCH * TILE_B;
 unroll_for(uint ki = 0; ki < CEIL_DIV(LEFTOVER_IFM, TILE_K); ++ki) {
 wei = FILTER_BLOCK_READ(weights, weights_offset);
 weights_offset += TILE_K_OFM * SIMD;
 unroll_for (uint kii = 0; kii < TILE_K; ++kii) {
 unroll_for (uint fi = 0; fi < TILE_OFM; ++fi) {
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 const uint total_k = ki * TILE_K + kii;
 if (total_k < LEFTOVER_IFM) {
 INPUT0_TYPE in_val = _sub_group_shuffle(((INPUT0_TYPE*)(&in_0[bi]))[total_k / SIMD], total_k % SIMD);
 ((ACCUMULATOR_TYPE*)(&acc[bi]))[fi] += in_val * ((FILTER_TYPE*)(&wei))[kii * TILE_OFM + fi];
 }
 }
 }
 }
 }
 }
 #undef LEFTOVER_IFM
#endif
 ACTIVATION_VEC_TYPE activated[TILE_B] = { };
 for (uint bi = 0; bi < TILE_B; ++bi) {
 activated[bi] = TO_ACTIVATION_VEC_TYPE(acc[bi]);
 }
#if BIAS_TERM
 #if TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0
 BIAS_VEC_TYPE bias = BIAS_BLOCK_READ(biases, out_f);
 #else
 BIAS_VEC_TYPE bias = 0;
 unroll_for(uint fi = 0; fi < TILE_OFM; ++fi) {
 ((BIAS_TYPE*)(&bias))[fi] = biases[out_f + sglid + fi * SIMD];
 }
 #endif
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 activated[bi] += TO_ACTIVATION_VEC_TYPE(bias);
 }
#endif
 OUTPUT_VEC_TYPE result[TILE_B] = { };
#if HAS_FUSED_OPS
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 #if TILE_OFM > 1
 unroll_for(uint fi = 0; fi < TILE_OFM; ++fi) {
 FUSED_OPS_VEC;
 result[bi][fi] = FUSED_OPS_RESULT_VEC;
 }
 #else
 FUSED_OPS_SCALAR;
 result[bi] = FUSED_OPS_RESULT_SCALAR;
 #endif
 }
#else
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 result[bi] = TO_OUTPUT_VEC_TYPE(ACTIVATION_TYPED(activated[bi], ACTIVATION_PARAMS_TYPED));
 }
#endif
 uint output_offset = out_f * TILE_OUT_F_PITCH + out_b * TILE_OUT_B_PITCH + OUTPUT_OFFSET;
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
#if IS_DYNAMIC
 #define WRITE_OUTPUT(bi) do { if (bi + out_b < BATCH_SIZE) OUTPUT_BLOCK_WRITE(output, output_offset, result[bi]); output_offset += TILE_OUT_B_PITCH; } while (false)
#else
 #define WRITE_OUTPUT(bi) do { OUTPUT_BLOCK_WRITE(output, output_offset, result[bi]); output_offset += TILE_OUT_B_PITCH; } while (false)
#endif
 CONST_LOOP(TILE_B, WRITE_OUTPUT);
 #undef WRITE_OUTPUT
 } else {
 output_offset += sglid;
 for (uint bi = 0; bi < TILE_B; ++bi) {
 for (uint fi = 0; fi < TILE_OFM; ++fi) {
 const bool should_write =
#if IS_DYNAMIC
 bi + out_b < BATCH_SIZE &&
#endif
 (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 ||
 out_f + fi * SIMD + sglid < TILE_OUT_F_NUM);
 if (should_write) {
 output[output_offset] = ((OUTPUT_TYPE*)(&result[bi]))[fi];
 }
 output_offset += SIMD;
 }
 output_offset += TILE_OUT_B_PITCH - TILE_OFM * SIMD;
 }
 }
}
#undef INPUT_VEC_TYPE
#undef ACCUMULATOR_VEC_TYPE
#undef FILTER_VEC_TYPE
#undef BIAS_VEC_TYPE
#undef OUTPUT_VEC_TYPE
#undef ACTIVATION_VEC_TYPE
#undef TO_OUTPUT_VEC_TYPE
#undef TO_ACTIVATION_VEC_TYPE
#undef INPUT_BLOCK_READ
#undef FILTER_BLOCK_READ
#undef BIAS_BLOCK_READ
#undef OUTPUT_BLOCK_WRITE
#undef USE_BLOCK_WRITE
#undef MAIN_LOOP_ELEMENTS_COUNT
#ifdef INPUT_VEC_TYPE
#undef INPUT_VEC_TYPE
#endif
#ifdef ACCUMULATOR_VEC_TYPE
#undef ACCUMULATOR_VEC_TYPE
#endif
#ifdef FILTER_VEC_TYPE
#undef FILTER_VEC_TYPE
#endif
#ifdef BIAS_VEC_TYPE
#undef BIAS_VEC_TYPE
#endif
#ifdef OUTPUT_VEC_TYPE
#undef OUTPUT_VEC_TYPE
#endif
#ifdef ACTIVATION_VEC_TYPE
#undef ACTIVATION_VEC_TYPE
#endif
#ifdef TO_OUTPUT_VEC_TYPE
#undef TO_OUTPUT_VEC_TYPE
#endif
#ifdef TO_ACTIVATION_VEC_TYPE
#undef TO_ACTIVATION_VEC_TYPE
#endif
#ifdef INPUT_BLOCK_READ
#undef INPUT_BLOCK_READ
#endif
#ifdef FILTER_BLOCK_READ
#undef FILTER_BLOCK_READ
#endif
#ifdef BIAS_BLOCK_READ
#undef BIAS_BLOCK_READ
#endif
#ifdef OUTPUT_BLOCK_WRITE
#undef OUTPUT_BLOCK_WRITE
#endif
#ifdef USE_BLOCK_WRITE
#undef USE_BLOCK_WRITE
#endif
#ifdef LOAD_IN_0
#undef LOAD_IN_0
#endif
#ifdef LEFTOVER_IFM
#undef LEFTOVER_IFM
#endif
#ifdef LOAD_IN_0
#undef LOAD_IN_0
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#ifdef WRITE_OUTPUT_FEATURE
#undef WRITE_OUTPUT_FEATURE
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#undef KERNEL
#undef FUNC
#undef FUNC_CALL
#undef CONST_ARRAY_DECL
#undef CONST_ARRAY_REF
#ifdef FP64_SUPPORTED
#undef FP64_SUPPORTED
#endif
#ifdef FP16_SUPPORTED
#undef FP16_SUPPORTED
#endif
#ifdef FP16_UNIT_USED
#undef FP16_UNIT_USED
#endif
#ifdef INT8_UNIT_USED
#undef INT8_UNIT_USED
#endif
#ifdef INT32_UNIT_USED
#undef INT32_UNIT_USED
#endif
#ifdef INT64_UNIT_USED
#undef INT64_UNIT_USED
#endif
#ifdef UINT8_UNIT_USED
#undef UINT8_UNIT_USED
#endif
#ifdef UINT32_UNIT_USED
#undef UINT32_UNIT_USED
#endif
#ifdef UNIT_TYPE
#undef UNIT_TYPE
#endif
#ifdef UNIT_VAL_MAX
#undef UNIT_VAL_MAX
#endif
#ifdef UNIT_VAL_MIN
#undef UNIT_VAL_MIN
#endif
#ifdef UNIT_VAL_ONE
#undef UNIT_VAL_ONE
#endif
#ifdef UNIT_VAL_ZERO
#undef UNIT_VAL_ZERO
#endif
#ifdef TO_UNIT_TYPE
#undef TO_UNIT_TYPE
#endif
#ifdef TO_UNIT_TYPE_SAT
#undef TO_UNIT_TYPE_SAT
#endif
#ifdef AS_UNIT_TYPE
#undef AS_UNIT_TYPE
#endif
#ifdef UNIT_MAX_FUNC
#undef UNIT_MAX_FUNC
#endif
#ifdef UNIT_MIN_FUNC
#undef UNIT_MIN_FUNC
#endif
#ifdef UNIT_ABS_FUNC
#undef UNIT_ABS_FUNC
#endif
#ifdef UNIT_TYPE_SIZE
#undef UNIT_TYPE_SIZE
#endif
#ifdef UNIT_IS_FP
#undef UNIT_IS_FP
#endif
#ifdef NL_M
#undef NL_M
#endif
#ifdef NL_N
#undef NL_N
#endif
#ifdef ACTIVATION_FUNC_TYPE
#undef ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_VAL_MAX
#undef ACTIVATION_FUNC_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_VAL_MIN
#undef ACTIVATION_FUNC_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_VAL_ONE
#undef ACTIVATION_FUNC_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_VAL_ZERO
#undef ACTIVATION_FUNC_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE
#undef TO_ACTIVATION_FUNC_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPE
#undef AS_ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_MAX_FUNC
#undef ACTIVATION_FUNC_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_MIN_FUNC
#undef ACTIVATION_FUNC_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_ABS_FUNC
#undef ACTIVATION_FUNC_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_IS_FP
#undef ACTIVATION_FUNC_IS_FP
#endif
#ifdef ACTIVATION_PARAMS
#undef ACTIVATION_PARAMS
#endif
#ifdef ACTIVATION_FUNC
#undef ACTIVATION_FUNC
#endif
#ifdef ACTIVATION
#undef ACTIVATION
#endif
#ifdef INPUT0_SIZE_X
#undef INPUT0_SIZE_X
#endif
#ifdef INPUT0_SIZE_Y
#undef INPUT0_SIZE_Y
#endif
#ifdef INPUT0_SIZE_Z
#undef INPUT0_SIZE_Z
#endif
#ifdef INPUT0_SIZE_W
#undef INPUT0_SIZE_W
#endif
#ifdef INPUT0_SIZE_U
#undef INPUT0_SIZE_U
#endif
#ifdef INPUT0_SIZE_V
#undef INPUT0_SIZE_V
#endif
#ifdef INPUT0_FEATURE_NUM
#undef INPUT0_FEATURE_NUM
#endif
#ifdef INPUT0_BATCH_NUM
#undef INPUT0_BATCH_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_X
#undef INPUT0_PAD_BEFORE_SIZE_X
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Y
#undef INPUT0_PAD_BEFORE_SIZE_Y
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Z
#undef INPUT0_PAD_BEFORE_SIZE_Z
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_W
#undef INPUT0_PAD_BEFORE_SIZE_W
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_U
#undef INPUT0_PAD_BEFORE_SIZE_U
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_V
#undef INPUT0_PAD_BEFORE_SIZE_V
#endif
#ifdef INPUT0_PAD_BEFORE_FEATURE_NUM
#undef INPUT0_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_BATCH_NUM
#undef INPUT0_PAD_BEFORE_BATCH_NUM
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_X
#undef INPUT0_PAD_AFTER_SIZE_X
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Y
#undef INPUT0_PAD_AFTER_SIZE_Y
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Z
#undef INPUT0_PAD_AFTER_SIZE_Z
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_W
#undef INPUT0_PAD_AFTER_SIZE_W
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_U
#undef INPUT0_PAD_AFTER_SIZE_U
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_V
#undef INPUT0_PAD_AFTER_SIZE_V
#endif
#ifdef INPUT0_PAD_AFTER_FEATURE_NUM
#undef INPUT0_PAD_AFTER_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_AFTER_BATCH_NUM
#undef INPUT0_PAD_AFTER_BATCH_NUM
#endif
#ifdef INPUT0_X_PITCH
#undef INPUT0_X_PITCH
#endif
#ifdef INPUT0_Y_PITCH
#undef INPUT0_Y_PITCH
#endif
#ifdef INPUT0_Z_PITCH
#undef INPUT0_Z_PITCH
#endif
#ifdef INPUT0_W_PITCH
#undef INPUT0_W_PITCH
#endif
#ifdef INPUT0_U_PITCH
#undef INPUT0_U_PITCH
#endif
#ifdef INPUT0_V_PITCH
#undef INPUT0_V_PITCH
#endif
#ifdef INPUT0_FEATURE_PITCH
#undef INPUT0_FEATURE_PITCH
#endif
#ifdef INPUT0_BATCH_PITCH
#undef INPUT0_BATCH_PITCH
#endif
#ifdef INPUT0_GET_INDEX_SAFE
#undef INPUT0_GET_INDEX_SAFE
#endif
#ifdef INPUT0_GET_INDEX
#undef INPUT0_GET_INDEX
#endif
#ifdef INPUT0_GET_INDEX_RAW
#undef INPUT0_GET_INDEX_RAW
#endif
#ifdef INPUT0_VIEW_OFFSET
#undef INPUT0_VIEW_OFFSET
#endif
#ifdef INPUT0_LENGTH
#undef INPUT0_LENGTH
#endif
#ifdef INPUT0_DIMS
#undef INPUT0_DIMS
#endif
#ifdef INPUT0_SIMPLE
#undef INPUT0_SIMPLE
#endif
#ifdef INPUT0_GROUPED
#undef INPUT0_GROUPED
#endif
#ifdef INPUT0_LAYOUT_BFYX
#undef INPUT0_LAYOUT_BFYX
#endif
#ifdef INPUT0_TYPE
#undef INPUT0_TYPE
#endif
#ifdef INPUT0_VAL_MAX
#undef INPUT0_VAL_MAX
#endif
#ifdef INPUT0_VAL_MIN
#undef INPUT0_VAL_MIN
#endif
#ifdef INPUT0_VAL_ONE
#undef INPUT0_VAL_ONE
#endif
#ifdef INPUT0_VAL_ZERO
#undef INPUT0_VAL_ZERO
#endif
#ifdef TO_INPUT0_TYPE
#undef TO_INPUT0_TYPE
#endif
#ifdef TO_INPUT0_TYPE_SAT
#undef TO_INPUT0_TYPE_SAT
#endif
#ifdef AS_INPUT0_TYPE
#undef AS_INPUT0_TYPE
#endif
#ifdef INPUT0_MAX_FUNC
#undef INPUT0_MAX_FUNC
#endif
#ifdef INPUT0_MIN_FUNC
#undef INPUT0_MIN_FUNC
#endif
#ifdef INPUT0_ABS_FUNC
#undef INPUT0_ABS_FUNC
#endif
#ifdef INPUT0_TYPE_SIZE
#undef INPUT0_TYPE_SIZE
#endif
#ifdef INPUT0_IS_FP
#undef INPUT0_IS_FP
#endif
#ifdef INPUT0_OFFSET
#undef INPUT0_OFFSET
#endif
#ifdef INPUT0_SIZES_DATA
#undef INPUT0_SIZES_DATA
#endif
#ifdef INPUT0_PITCHES
#undef INPUT0_PITCHES
#endif
#ifdef INPUT0_PAD_BEFORE
#undef INPUT0_PAD_BEFORE
#endif
#ifdef INPUT0_PAD_AFTER
#undef INPUT0_PAD_AFTER
#endif
#ifdef OUTPUT_SIZE_X
#undef OUTPUT_SIZE_X
#endif
#ifdef OUTPUT_SIZE_Y
#undef OUTPUT_SIZE_Y
#endif
#ifdef OUTPUT_SIZE_Z
#undef OUTPUT_SIZE_Z
#endif
#ifdef OUTPUT_SIZE_W
#undef OUTPUT_SIZE_W
#endif
#ifdef OUTPUT_SIZE_U
#undef OUTPUT_SIZE_U
#endif
#ifdef OUTPUT_SIZE_V
#undef OUTPUT_SIZE_V
#endif
#ifdef OUTPUT_FEATURE_NUM
#undef OUTPUT_FEATURE_NUM
#endif
#ifdef OUTPUT_BATCH_NUM
#undef OUTPUT_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_X
#undef OUTPUT_PAD_BEFORE_SIZE_X
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Y
#undef OUTPUT_PAD_BEFORE_SIZE_Y
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Z
#undef OUTPUT_PAD_BEFORE_SIZE_Z
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_W
#undef OUTPUT_PAD_BEFORE_SIZE_W
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_U
#undef OUTPUT_PAD_BEFORE_SIZE_U
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_V
#undef OUTPUT_PAD_BEFORE_SIZE_V
#endif
#ifdef OUTPUT_PAD_BEFORE_FEATURE_NUM
#undef OUTPUT_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_BATCH_NUM
#undef OUTPUT_PAD_BEFORE_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_X
#undef OUTPUT_PAD_AFTER_SIZE_X
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Y
#undef OUTPUT_PAD_AFTER_SIZE_Y
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Z
#undef OUTPUT_PAD_AFTER_SIZE_Z
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_W
#undef OUTPUT_PAD_AFTER_SIZE_W
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_U
#undef OUTPUT_PAD_AFTER_SIZE_U
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_V
#undef OUTPUT_PAD_AFTER_SIZE_V
#endif
#ifdef OUTPUT_PAD_AFTER_FEATURE_NUM
#undef OUTPUT_PAD_AFTER_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_BATCH_NUM
#undef OUTPUT_PAD_AFTER_BATCH_NUM
#endif
#ifdef OUTPUT_X_PITCH
#undef OUTPUT_X_PITCH
#endif
#ifdef OUTPUT_Y_PITCH
#undef OUTPUT_Y_PITCH
#endif
#ifdef OUTPUT_Z_PITCH
#undef OUTPUT_Z_PITCH
#endif
#ifdef OUTPUT_W_PITCH
#undef OUTPUT_W_PITCH
#endif
#ifdef OUTPUT_U_PITCH
#undef OUTPUT_U_PITCH
#endif
#ifdef OUTPUT_V_PITCH
#undef OUTPUT_V_PITCH
#endif
#ifdef OUTPUT_FEATURE_PITCH
#undef OUTPUT_FEATURE_PITCH
#endif
#ifdef OUTPUT_BATCH_PITCH
#undef OUTPUT_BATCH_PITCH
#endif
#ifdef OUTPUT_GET_INDEX_SAFE
#undef OUTPUT_GET_INDEX_SAFE
#endif
#ifdef OUTPUT_GET_INDEX
#undef OUTPUT_GET_INDEX
#endif
#ifdef OUTPUT_GET_INDEX_RAW
#undef OUTPUT_GET_INDEX_RAW
#endif
#ifdef OUTPUT_VIEW_OFFSET
#undef OUTPUT_VIEW_OFFSET
#endif
#ifdef OUTPUT_LENGTH
#undef OUTPUT_LENGTH
#endif
#ifdef OUTPUT_DIMS
#undef OUTPUT_DIMS
#endif
#ifdef OUTPUT_SIMPLE
#undef OUTPUT_SIMPLE
#endif
#ifdef OUTPUT_GROUPED
#undef OUTPUT_GROUPED
#endif
#ifdef OUTPUT_LAYOUT_BF
#undef OUTPUT_LAYOUT_BF
#endif
#ifdef OUTPUT_TYPE
#undef OUTPUT_TYPE
#endif
#ifdef OUTPUT_VAL_MAX
#undef OUTPUT_VAL_MAX
#endif
#ifdef OUTPUT_VAL_MIN
#undef OUTPUT_VAL_MIN
#endif
#ifdef OUTPUT_VAL_ONE
#undef OUTPUT_VAL_ONE
#endif
#ifdef OUTPUT_VAL_ZERO
#undef OUTPUT_VAL_ZERO
#endif
#ifdef TO_OUTPUT_TYPE
#undef TO_OUTPUT_TYPE
#endif
#ifdef TO_OUTPUT_TYPE_SAT
#undef TO_OUTPUT_TYPE_SAT
#endif
#ifdef AS_OUTPUT_TYPE
#undef AS_OUTPUT_TYPE
#endif
#ifdef OUTPUT_MAX_FUNC
#undef OUTPUT_MAX_FUNC
#endif
#ifdef OUTPUT_MIN_FUNC
#undef OUTPUT_MIN_FUNC
#endif
#ifdef OUTPUT_ABS_FUNC
#undef OUTPUT_ABS_FUNC
#endif
#ifdef OUTPUT_TYPE_SIZE
#undef OUTPUT_TYPE_SIZE
#endif
#ifdef OUTPUT_IS_FP
#undef OUTPUT_IS_FP
#endif
#ifdef OUTPUT_OFFSET
#undef OUTPUT_OFFSET
#endif
#ifdef OUTPUT_SIZES_DATA
#undef OUTPUT_SIZES_DATA
#endif
#ifdef OUTPUT_PITCHES
#undef OUTPUT_PITCHES
#endif
#ifdef OUTPUT_PAD_BEFORE
#undef OUTPUT_PAD_BEFORE
#endif
#ifdef OUTPUT_PAD_AFTER
#undef OUTPUT_PAD_AFTER
#endif
#ifdef OPTIONAL_SHAPE_INFO_ARG
#undef OPTIONAL_SHAPE_INFO_ARG
#endif
#ifdef OPTIONAL_SHAPE_INFO_TENSOR
#undef OPTIONAL_SHAPE_INFO_TENSOR
#endif
#ifdef FILTER_SIZE_X
#undef FILTER_SIZE_X
#endif
#ifdef FILTER_SIZE_Y
#undef FILTER_SIZE_Y
#endif
#ifdef FILTER_SIZE_Z
#undef FILTER_SIZE_Z
#endif
#ifdef FILTER_IFM_NUM
#undef FILTER_IFM_NUM
#endif
#ifdef FILTER_OFM_NUM
#undef FILTER_OFM_NUM
#endif
#ifdef FILTER_GROUPS_NUM
#undef FILTER_GROUPS_NUM
#endif
#ifdef FILTER_X_PITCH
#undef FILTER_X_PITCH
#endif
#ifdef FILTER_Y_PITCH
#undef FILTER_Y_PITCH
#endif
#ifdef FILTER_Z_PITCH
#undef FILTER_Z_PITCH
#endif
#ifdef FILTER_IFM_PITCH
#undef FILTER_IFM_PITCH
#endif
#ifdef FILTER_OFM_PITCH
#undef FILTER_OFM_PITCH
#endif
#ifdef FILTER_GROUPS_PITCH
#undef FILTER_GROUPS_PITCH
#endif
#ifdef FILTER_VIEW_OFFSET
#undef FILTER_VIEW_OFFSET
#endif
#ifdef FILTER_LENGTH
#undef FILTER_LENGTH
#endif
#ifdef FILTER_DIMS
#undef FILTER_DIMS
#endif
#ifdef FILTER_SIMPLE
#undef FILTER_SIMPLE
#endif
#ifdef FILTER_GROUPED
#undef FILTER_GROUPED
#endif
#ifdef FILTER_LAYOUT_OS_IYX_OSV32
#undef FILTER_LAYOUT_OS_IYX_OSV32
#endif
#ifdef FILTER_TYPE
#undef FILTER_TYPE
#endif
#ifdef FILTER_VAL_MAX
#undef FILTER_VAL_MAX
#endif
#ifdef FILTER_VAL_MIN
#undef FILTER_VAL_MIN
#endif
#ifdef FILTER_VAL_ONE
#undef FILTER_VAL_ONE
#endif
#ifdef FILTER_VAL_ZERO
#undef FILTER_VAL_ZERO
#endif
#ifdef TO_FILTER_TYPE
#undef TO_FILTER_TYPE
#endif
#ifdef TO_FILTER_TYPE_SAT
#undef TO_FILTER_TYPE_SAT
#endif
#ifdef AS_FILTER_TYPE
#undef AS_FILTER_TYPE
#endif
#ifdef FILTER_MAX_FUNC
#undef FILTER_MAX_FUNC
#endif
#ifdef FILTER_MIN_FUNC
#undef FILTER_MIN_FUNC
#endif
#ifdef FILTER_ABS_FUNC
#undef FILTER_ABS_FUNC
#endif
#ifdef FILTER_TYPE_SIZE
#undef FILTER_TYPE_SIZE
#endif
#ifdef FILTER_IS_FP
#undef FILTER_IS_FP
#endif
#ifdef FILTER_OFFSET
#undef FILTER_OFFSET
#endif
#ifdef FILTER_SIZES_DATA
#undef FILTER_SIZES_DATA
#endif
#ifdef FILTER_PITCHES
#undef FILTER_PITCHES
#endif
#ifdef FILTER_PAD_BEFORE
#undef FILTER_PAD_BEFORE
#endif
#ifdef FILTER_PAD_AFTER
#undef FILTER_PAD_AFTER
#endif
#ifdef BIAS_TERM
#undef BIAS_TERM
#endif
#ifdef BIAS_SIZE_X
#undef BIAS_SIZE_X
#endif
#ifdef BIAS_SIZE_Y
#undef BIAS_SIZE_Y
#endif
#ifdef BIAS_SIZE_Z
#undef BIAS_SIZE_Z
#endif
#ifdef BIAS_SIZE_W
#undef BIAS_SIZE_W
#endif
#ifdef BIAS_SIZE_U
#undef BIAS_SIZE_U
#endif
#ifdef BIAS_SIZE_V
#undef BIAS_SIZE_V
#endif
#ifdef BIAS_FEATURE_NUM
#undef BIAS_FEATURE_NUM
#endif
#ifdef BIAS_BATCH_NUM
#undef BIAS_BATCH_NUM
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_X
#undef BIAS_PAD_BEFORE_SIZE_X
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_Y
#undef BIAS_PAD_BEFORE_SIZE_Y
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_Z
#undef BIAS_PAD_BEFORE_SIZE_Z
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_W
#undef BIAS_PAD_BEFORE_SIZE_W
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_U
#undef BIAS_PAD_BEFORE_SIZE_U
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_V
#undef BIAS_PAD_BEFORE_SIZE_V
#endif
#ifdef BIAS_PAD_BEFORE_FEATURE_NUM
#undef BIAS_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef BIAS_PAD_BEFORE_BATCH_NUM
#undef BIAS_PAD_BEFORE_BATCH_NUM
#endif
#ifdef BIAS_PAD_AFTER_SIZE_X
#undef BIAS_PAD_AFTER_SIZE_X
#endif
#ifdef BIAS_PAD_AFTER_SIZE_Y
#undef BIAS_PAD_AFTER_SIZE_Y
#endif
#ifdef BIAS_PAD_AFTER_SIZE_Z
#undef BIAS_PAD_AFTER_SIZE_Z
#endif
#ifdef BIAS_PAD_AFTER_SIZE_W
#undef BIAS_PAD_AFTER_SIZE_W
#endif
#ifdef BIAS_PAD_AFTER_SIZE_U
#undef BIAS_PAD_AFTER_SIZE_U
#endif
#ifdef BIAS_PAD_AFTER_SIZE_V
#undef BIAS_PAD_AFTER_SIZE_V
#endif
#ifdef BIAS_PAD_AFTER_FEATURE_NUM
#undef BIAS_PAD_AFTER_FEATURE_NUM
#endif
#ifdef BIAS_PAD_AFTER_BATCH_NUM
#undef BIAS_PAD_AFTER_BATCH_NUM
#endif
#ifdef BIAS_X_PITCH
#undef BIAS_X_PITCH
#endif
#ifdef BIAS_Y_PITCH
#undef BIAS_Y_PITCH
#endif
#ifdef BIAS_Z_PITCH
#undef BIAS_Z_PITCH
#endif
#ifdef BIAS_W_PITCH
#undef BIAS_W_PITCH
#endif
#ifdef BIAS_U_PITCH
#undef BIAS_U_PITCH
#endif
#ifdef BIAS_V_PITCH
#undef BIAS_V_PITCH
#endif
#ifdef BIAS_FEATURE_PITCH
#undef BIAS_FEATURE_PITCH
#endif
#ifdef BIAS_BATCH_PITCH
#undef BIAS_BATCH_PITCH
#endif
#ifdef BIAS_GET_INDEX_SAFE
#undef BIAS_GET_INDEX_SAFE
#endif
#ifdef BIAS_GET_INDEX
#undef BIAS_GET_INDEX
#endif
#ifdef BIAS_GET_INDEX_RAW
#undef BIAS_GET_INDEX_RAW
#endif
#ifdef BIAS_VIEW_OFFSET
#undef BIAS_VIEW_OFFSET
#endif
#ifdef BIAS_LENGTH
#undef BIAS_LENGTH
#endif
#ifdef BIAS_DIMS
#undef BIAS_DIMS
#endif
#ifdef BIAS_SIMPLE
#undef BIAS_SIMPLE
#endif
#ifdef BIAS_GROUPED
#undef BIAS_GROUPED
#endif
#ifdef BIAS_LAYOUT_BF
#undef BIAS_LAYOUT_BF
#endif
#ifdef BIAS_TYPE
#undef BIAS_TYPE
#endif
#ifdef BIAS_VAL_MAX
#undef BIAS_VAL_MAX
#endif
#ifdef BIAS_VAL_MIN
#undef BIAS_VAL_MIN
#endif
#ifdef BIAS_VAL_ONE
#undef BIAS_VAL_ONE
#endif
#ifdef BIAS_VAL_ZERO
#undef BIAS_VAL_ZERO
#endif
#ifdef TO_BIAS_TYPE
#undef TO_BIAS_TYPE
#endif
#ifdef TO_BIAS_TYPE_SAT
#undef TO_BIAS_TYPE_SAT
#endif
#ifdef AS_BIAS_TYPE
#undef AS_BIAS_TYPE
#endif
#ifdef BIAS_MAX_FUNC
#undef BIAS_MAX_FUNC
#endif
#ifdef BIAS_MIN_FUNC
#undef BIAS_MIN_FUNC
#endif
#ifdef BIAS_ABS_FUNC
#undef BIAS_ABS_FUNC
#endif
#ifdef BIAS_TYPE_SIZE
#undef BIAS_TYPE_SIZE
#endif
#ifdef BIAS_IS_FP
#undef BIAS_IS_FP
#endif
#ifdef BIAS_OFFSET
#undef BIAS_OFFSET
#endif
#ifdef BIAS_SIZES_DATA
#undef BIAS_SIZES_DATA
#endif
#ifdef BIAS_PITCHES
#undef BIAS_PITCHES
#endif
#ifdef BIAS_PAD_BEFORE
#undef BIAS_PAD_BEFORE
#endif
#ifdef BIAS_PAD_AFTER
#undef BIAS_PAD_AFTER
#endif
#ifdef BIAS_PER_OUTPUT
#undef BIAS_PER_OUTPUT
#endif
#ifdef BIAS_PER_OFM
#undef BIAS_PER_OFM
#endif
#ifdef INPUT0_ELEMENTS_COUNT
#undef INPUT0_ELEMENTS_COUNT
#endif
#ifdef SIMD
#undef SIMD
#endif
#ifdef TILE_B
#undef TILE_B
#endif
#ifdef TILE_OFM
#undef TILE_OFM
#endif
#ifdef TILE_IFM
#undef TILE_IFM
#endif
#ifdef TILE_K
#undef TILE_K
#endif
#ifdef TILE_K_OFM
#undef TILE_K_OFM
#endif
#ifdef DISPATCH_BSV
#undef DISPATCH_BSV
#endif
#ifdef DISPATCH_FSV
#undef DISPATCH_FSV
#endif
#ifdef CONST_LOOP_CALL
#undef CONST_LOOP_CALL
#endif
#ifdef CONST_LOOP_1
#undef CONST_LOOP_1
#endif
#ifdef CONST_LOOP_2
#undef CONST_LOOP_2
#endif
#ifdef CONST_LOOP_3
#undef CONST_LOOP_3
#endif
#ifdef CONST_LOOP_4
#undef CONST_LOOP_4
#endif
#ifdef CONST_LOOP_5
#undef CONST_LOOP_5
#endif
#ifdef CONST_LOOP
#undef CONST_LOOP
#endif
#ifdef REALIGN_FP16_OFFSET
#undef REALIGN_FP16_OFFSET
#endif
#ifdef ACTIVATION_TYPE
#undef ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_VAL_MAX
#undef ACTIVATION_VAL_MAX
#endif
#ifdef ACTIVATION_VAL_MIN
#undef ACTIVATION_VAL_MIN
#endif
#ifdef ACTIVATION_VAL_ONE
#undef ACTIVATION_VAL_ONE
#endif
#ifdef ACTIVATION_VAL_ZERO
#undef ACTIVATION_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_TYPE
#undef TO_ACTIVATION_TYPE
#endif
#ifdef TO_ACTIVATION_TYPE_SAT
#undef TO_ACTIVATION_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_TYPE
#undef AS_ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_MAX_FUNC
#undef ACTIVATION_MAX_FUNC
#endif
#ifdef ACTIVATION_MIN_FUNC
#undef ACTIVATION_MIN_FUNC
#endif
#ifdef ACTIVATION_ABS_FUNC
#undef ACTIVATION_ABS_FUNC
#endif
#ifdef ACTIVATION_TYPE_SIZE
#undef ACTIVATION_TYPE_SIZE
#endif
#ifdef ACTIVATION_IS_FP
#undef ACTIVATION_IS_FP
#endif
#ifdef NL_M_TYPED
#undef NL_M_TYPED
#endif
#ifdef NL_N_TYPED
#undef NL_N_TYPED
#endif
#ifdef ACTIVATION_FUNC_TYPED_TYPE
#undef ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_MAX
#undef ACTIVATION_FUNC_TYPED_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_MIN
#undef ACTIVATION_FUNC_TYPED_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_ONE
#undef ACTIVATION_FUNC_TYPED_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_ZERO
#undef ACTIVATION_FUNC_TYPED_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_TYPE
#undef TO_ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPED_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPED_TYPE
#undef AS_ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_MAX_FUNC
#undef ACTIVATION_FUNC_TYPED_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_MIN_FUNC
#undef ACTIVATION_FUNC_TYPED_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_ABS_FUNC
#undef ACTIVATION_FUNC_TYPED_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPED_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_TYPED_IS_FP
#undef ACTIVATION_FUNC_TYPED_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_TYPED
#undef ACTIVATION_PARAMS_TYPED
#endif
#ifdef ACTIVATION_FUNC_TYPED
#undef ACTIVATION_FUNC_TYPED
#endif
#ifdef ACTIVATION_TYPED
#undef ACTIVATION_TYPED
#endif
#ifdef ACCUMULATOR_TYPE
#undef ACCUMULATOR_TYPE
#endif
#ifdef ACCUMULATOR_VAL_MAX
#undef ACCUMULATOR_VAL_MAX
#endif
#ifdef ACCUMULATOR_VAL_MIN
#undef ACCUMULATOR_VAL_MIN
#endif
#ifdef ACCUMULATOR_VAL_ONE
#undef ACCUMULATOR_VAL_ONE
#endif
#ifdef ACCUMULATOR_VAL_ZERO
#undef ACCUMULATOR_VAL_ZERO
#endif
#ifdef TO_ACCUMULATOR_TYPE
#undef TO_ACCUMULATOR_TYPE
#endif
#ifdef TO_ACCUMULATOR_TYPE_SAT
#undef TO_ACCUMULATOR_TYPE_SAT
#endif
#ifdef AS_ACCUMULATOR_TYPE
#undef AS_ACCUMULATOR_TYPE
#endif
#ifdef ACCUMULATOR_MAX_FUNC
#undef ACCUMULATOR_MAX_FUNC
#endif
#ifdef ACCUMULATOR_MIN_FUNC
#undef ACCUMULATOR_MIN_FUNC
#endif
#ifdef ACCUMULATOR_ABS_FUNC
#undef ACCUMULATOR_ABS_FUNC
#endif
#ifdef ACCUMULATOR_TYPE_SIZE
#undef ACCUMULATOR_TYPE_SIZE
#endif
#ifdef ACCUMULATOR_IS_FP
#undef ACCUMULATOR_IS_FP
#endif
#ifdef TILE_OUT_F_NUM
#undef TILE_OUT_F_NUM
#endif
#ifdef TILE_OUT_F_PITCH
#undef TILE_OUT_F_PITCH
#endif
#ifdef TILE_IN_B_PITCH
#undef TILE_IN_B_PITCH
#endif
#ifdef TILE_OUT_B_PITCH
#undef TILE_OUT_B_PITCH
#endif
#ifdef BATCH_SIZE
#undef BATCH_SIZE
#endif

//====================================================
// Kernel template: fully_connected_gpu_bf_tiled 
// Kernel name: fully_connected_gpu_bf_tiled_17903421672701997615_0
#define KERNEL(name) __kernel void fully_connected_gpu_bf_tiled_17903421672701997615_0
#define FUNC(name)  _##name##_fully_connected_gpu_bf_tiled_17903421672701997615_0
#define FUNC_CALL(name)  _##name##_fully_connected_gpu_bf_tiled_17903421672701997615_0
#define CONST_ARRAY_DECL(name) __constant size_t  _##name##_fully_connected_gpu_bf_tiled_17903421672701997615_0 []
#define CONST_ARRAY_REF(name)  _##name##_fully_connected_gpu_bf_tiled_17903421672701997615_0
#define FP64_SUPPORTED 0
#define FP16_SUPPORTED 1
#define FP16_UNIT_USED 1
#define INT8_UNIT_USED 0
#define INT32_UNIT_USED 0
#define INT64_UNIT_USED 0
#define UINT8_UNIT_USED 0
#define UINT32_UNIT_USED 0
#define UNIT_TYPE half
#define UNIT_VAL_MAX HALF_MAX
#define UNIT_VAL_MIN -UNIT_VAL_MAX
#define UNIT_VAL_ONE 1.0h
#define UNIT_VAL_ZERO 0.0h
#define TO_UNIT_TYPE(v) convert_half(v)
#define TO_UNIT_TYPE_SAT(v) convert_half(v)
#define AS_UNIT_TYPE(v) as_half(v)
#define UNIT_MAX_FUNC fmax
#define UNIT_MIN_FUNC fmin
#define UNIT_ABS_FUNC fabs
#define UNIT_TYPE_SIZE 2
#define UNIT_IS_FP 1
#define NL_M_0 as_float(0x0)/*0.000000e+00*/
#define NL_N_0 as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_0_TYPE half
#define ACTIVATION_FUNC_0_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_0_VAL_MIN -ACTIVATION_FUNC_0_VAL_MAX
#define ACTIVATION_FUNC_0_VAL_ONE 1.0h
#define ACTIVATION_FUNC_0_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_0_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_0_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_0_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_0_MAX_FUNC fmax
#define ACTIVATION_FUNC_0_MIN_FUNC fmin
#define ACTIVATION_FUNC_0_ABS_FUNC fabs
#define ACTIVATION_FUNC_0_TYPE_SIZE 2
#define ACTIVATION_FUNC_0_IS_FP 1
#define ACTIVATION_PARAMS_0 NL_M_0, NL_N_0
#define ACTIVATION_FUNC_0(input, m, n) (ACTIVATION_FUNC_0_MAX_FUNC(ACTIVATION_FUNC_0_VAL_ZERO, input))
#define ACTIVATION_0(input, params) ACTIVATION_FUNC_0(input, params)
#define ACTIVATION_PARAMS ACTIVATION_PARAMS_0
#define ACTIVATION(input, params) ACTIVATION_FUNC_0(input, params)
#define INPUT0_SIZE_X 1
#define INPUT0_SIZE_Y 1
#define INPUT0_SIZE_Z 1
#define INPUT0_SIZE_W 1
#define INPUT0_SIZE_U 1
#define INPUT0_SIZE_V 1
#define INPUT0_FEATURE_NUM 512
#define INPUT0_BATCH_NUM 10
#define INPUT0_PAD_BEFORE_SIZE_X 0
#define INPUT0_PAD_BEFORE_SIZE_Y 0
#define INPUT0_PAD_BEFORE_SIZE_Z 0
#define INPUT0_PAD_BEFORE_SIZE_W 0
#define INPUT0_PAD_BEFORE_SIZE_U 0
#define INPUT0_PAD_BEFORE_SIZE_V 0
#define INPUT0_PAD_BEFORE_FEATURE_NUM 0
#define INPUT0_PAD_BEFORE_BATCH_NUM 0
#define INPUT0_PAD_AFTER_SIZE_X 0
#define INPUT0_PAD_AFTER_SIZE_Y 0
#define INPUT0_PAD_AFTER_SIZE_Z 0
#define INPUT0_PAD_AFTER_SIZE_W 0
#define INPUT0_PAD_AFTER_SIZE_U 0
#define INPUT0_PAD_AFTER_SIZE_V 0
#define INPUT0_PAD_AFTER_FEATURE_NUM 0
#define INPUT0_PAD_AFTER_BATCH_NUM 0
#define INPUT0_X_PITCH 1
#define INPUT0_Y_PITCH 1
#define INPUT0_Z_PITCH 1
#define INPUT0_W_PITCH 1
#define INPUT0_U_PITCH 1
#define INPUT0_V_PITCH 1
#define INPUT0_FEATURE_PITCH 1
#define INPUT0_BATCH_PITCH 512
#define INPUT0_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX(b, f, y, x) GET_DATA_INDEX(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(INPUT0, b, f, y, x)
#define INPUT0_VIEW_OFFSET 0
#define INPUT0_LENGTH 5120
#define INPUT0_DIMS 4
#define INPUT0_SIMPLE 1
#define INPUT0_GROUPED 0
#define INPUT0_LAYOUT_BFYX 1
#define INPUT0_TYPE half
#define INPUT0_VAL_MAX HALF_MAX
#define INPUT0_VAL_MIN -INPUT0_VAL_MAX
#define INPUT0_VAL_ONE 1.0h
#define INPUT0_VAL_ZERO 0.0h
#define TO_INPUT0_TYPE(v) convert_half(v)
#define TO_INPUT0_TYPE_SAT(v) convert_half(v)
#define AS_INPUT0_TYPE(v) as_half(v)
#define INPUT0_MAX_FUNC fmax
#define INPUT0_MIN_FUNC fmin
#define INPUT0_ABS_FUNC fabs
#define INPUT0_TYPE_SIZE 2
#define INPUT0_IS_FP 1
#define INPUT0_OFFSET 0
#define INPUT0_SIZES_DATA { 1,1,512,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(INPUT0_SIZES) = INPUT0_SIZES_DATA;
#define INPUT0_SIZES CONST_ARRAY_REF(INPUT0_SIZES)
#define INPUT0_PITCHES (size_t []){ 1,1,1,512,1,1,1,1,1, } 
#define INPUT0_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define INPUT0_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_SIZE_X 1
#define OUTPUT_SIZE_Y 1
#define OUTPUT_SIZE_Z 1
#define OUTPUT_SIZE_W 1
#define OUTPUT_SIZE_U 1
#define OUTPUT_SIZE_V 1
#define OUTPUT_FEATURE_NUM 512
#define OUTPUT_BATCH_NUM 10
#define OUTPUT_PAD_BEFORE_SIZE_X 0
#define OUTPUT_PAD_BEFORE_SIZE_Y 0
#define OUTPUT_PAD_BEFORE_SIZE_Z 0
#define OUTPUT_PAD_BEFORE_SIZE_W 0
#define OUTPUT_PAD_BEFORE_SIZE_U 0
#define OUTPUT_PAD_BEFORE_SIZE_V 0
#define OUTPUT_PAD_BEFORE_FEATURE_NUM 0
#define OUTPUT_PAD_BEFORE_BATCH_NUM 0
#define OUTPUT_PAD_AFTER_SIZE_X 0
#define OUTPUT_PAD_AFTER_SIZE_Y 0
#define OUTPUT_PAD_AFTER_SIZE_Z 0
#define OUTPUT_PAD_AFTER_SIZE_W 0
#define OUTPUT_PAD_AFTER_SIZE_U 0
#define OUTPUT_PAD_AFTER_SIZE_V 0
#define OUTPUT_PAD_AFTER_FEATURE_NUM 0
#define OUTPUT_PAD_AFTER_BATCH_NUM 0
#define OUTPUT_X_PITCH 1
#define OUTPUT_Y_PITCH 1
#define OUTPUT_Z_PITCH 1
#define OUTPUT_W_PITCH 1
#define OUTPUT_U_PITCH 1
#define OUTPUT_V_PITCH 1
#define OUTPUT_FEATURE_PITCH 1
#define OUTPUT_BATCH_PITCH 512
#define OUTPUT_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX(b, f, y, x) GET_DATA_INDEX(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(OUTPUT, b, f, y, x)
#define OUTPUT_VIEW_OFFSET 0
#define OUTPUT_LENGTH 5120
#define OUTPUT_DIMS 2
#define OUTPUT_SIMPLE 1
#define OUTPUT_GROUPED 0
#define OUTPUT_LAYOUT_BF 1
#define OUTPUT_TYPE half
#define OUTPUT_VAL_MAX HALF_MAX
#define OUTPUT_VAL_MIN -OUTPUT_VAL_MAX
#define OUTPUT_VAL_ONE 1.0h
#define OUTPUT_VAL_ZERO 0.0h
#define TO_OUTPUT_TYPE(v) convert_half(v)
#define TO_OUTPUT_TYPE_SAT(v) convert_half(v)
#define AS_OUTPUT_TYPE(v) as_half(v)
#define OUTPUT_MAX_FUNC fmax
#define OUTPUT_MIN_FUNC fmin
#define OUTPUT_ABS_FUNC fabs
#define OUTPUT_TYPE_SIZE 2
#define OUTPUT_IS_FP 1
#define OUTPUT_OFFSET 0
#define OUTPUT_SIZES_DATA { 512,10,1,1,1,1,1,1,1, } 
CONST_ARRAY_DECL(OUTPUT_SIZES) = OUTPUT_SIZES_DATA;
#define OUTPUT_SIZES CONST_ARRAY_REF(OUTPUT_SIZES)
#define OUTPUT_PITCHES (size_t []){ 1,512,1,1,1,1,1,1,1, } 
#define OUTPUT_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OPTIONAL_SHAPE_INFO_ARG 
#define OPTIONAL_SHAPE_INFO_TENSOR 
#define FILTER_SIZE_X 1
#define FILTER_SIZE_Y 1
#define FILTER_SIZE_Z 1
#define FILTER_IFM_NUM 512
#define FILTER_OFM_NUM 512
#define FILTER_GROUPS_NUM 1
#define FILTER_X_PITCH 1
#define FILTER_Y_PITCH 1
#define FILTER_Z_PITCH 1
#define FILTER_IFM_PITCH 1
#define FILTER_OFM_PITCH 512
#define FILTER_GROUPS_PITCH 1
#define FILTER_VIEW_OFFSET 0
#define FILTER_LENGTH 262144
#define FILTER_DIMS 4
#define FILTER_SIMPLE 0
#define FILTER_GROUPED 0
#define FILTER_LAYOUT_OS_IYX_OSV32 1
#define FILTER_TYPE half
#define FILTER_VAL_MAX HALF_MAX
#define FILTER_VAL_MIN -FILTER_VAL_MAX
#define FILTER_VAL_ONE 1.0h
#define FILTER_VAL_ZERO 0.0h
#define TO_FILTER_TYPE(v) convert_half(v)
#define TO_FILTER_TYPE_SAT(v) convert_half(v)
#define AS_FILTER_TYPE(v) as_half(v)
#define FILTER_MAX_FUNC fmax
#define FILTER_MIN_FUNC fmin
#define FILTER_ABS_FUNC fabs
#define FILTER_TYPE_SIZE 2
#define FILTER_IS_FP 1
#define FILTER_OFFSET 0
#define FILTER_SIZES_DATA { 1,1,512,512,1,1,1,1,1, } 
CONST_ARRAY_DECL(FILTER_SIZES) = FILTER_SIZES_DATA;
#define FILTER_SIZES CONST_ARRAY_REF(FILTER_SIZES)
#define FILTER_PITCHES (size_t []){ 1,1,1,512,1,1,1,1,1, } 
#define FILTER_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define FILTER_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_TERM 1
#define BIAS_SIZE_X 1
#define BIAS_SIZE_Y 1
#define BIAS_SIZE_Z 1
#define BIAS_SIZE_W 1
#define BIAS_SIZE_U 1
#define BIAS_SIZE_V 1
#define BIAS_FEATURE_NUM 512
#define BIAS_BATCH_NUM 1
#define BIAS_PAD_BEFORE_SIZE_X 0
#define BIAS_PAD_BEFORE_SIZE_Y 0
#define BIAS_PAD_BEFORE_SIZE_Z 0
#define BIAS_PAD_BEFORE_SIZE_W 0
#define BIAS_PAD_BEFORE_SIZE_U 0
#define BIAS_PAD_BEFORE_SIZE_V 0
#define BIAS_PAD_BEFORE_FEATURE_NUM 0
#define BIAS_PAD_BEFORE_BATCH_NUM 0
#define BIAS_PAD_AFTER_SIZE_X 0
#define BIAS_PAD_AFTER_SIZE_Y 0
#define BIAS_PAD_AFTER_SIZE_Z 0
#define BIAS_PAD_AFTER_SIZE_W 0
#define BIAS_PAD_AFTER_SIZE_U 0
#define BIAS_PAD_AFTER_SIZE_V 0
#define BIAS_PAD_AFTER_FEATURE_NUM 0
#define BIAS_PAD_AFTER_BATCH_NUM 0
#define BIAS_X_PITCH 1
#define BIAS_Y_PITCH 1
#define BIAS_Z_PITCH 1
#define BIAS_W_PITCH 1
#define BIAS_U_PITCH 1
#define BIAS_V_PITCH 1
#define BIAS_FEATURE_PITCH 1
#define BIAS_BATCH_PITCH 512
#define BIAS_GET_INDEX_SAFE(b, f, y, x) ((0 + (f)) % 512)
#define BIAS_GET_INDEX(b, f, y, x) (0 + (f))
#define BIAS_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(BIAS, b, f, y, x)
#define BIAS_VIEW_OFFSET 0
#define BIAS_LENGTH 512
#define BIAS_DIMS 2
#define BIAS_SIMPLE 1
#define BIAS_GROUPED 0
#define BIAS_LAYOUT_BF 1
#define BIAS_TYPE half
#define BIAS_VAL_MAX HALF_MAX
#define BIAS_VAL_MIN -BIAS_VAL_MAX
#define BIAS_VAL_ONE 1.0h
#define BIAS_VAL_ZERO 0.0h
#define TO_BIAS_TYPE(v) convert_half(v)
#define TO_BIAS_TYPE_SAT(v) convert_half(v)
#define AS_BIAS_TYPE(v) as_half(v)
#define BIAS_MAX_FUNC fmax
#define BIAS_MIN_FUNC fmin
#define BIAS_ABS_FUNC fabs
#define BIAS_TYPE_SIZE 2
#define BIAS_IS_FP 1
#define BIAS_OFFSET 0
#define BIAS_SIZES_DATA { 512,1,1,1,1,1,1,1,1, } 
CONST_ARRAY_DECL(BIAS_SIZES) = BIAS_SIZES_DATA;
#define BIAS_SIZES CONST_ARRAY_REF(BIAS_SIZES)
#define BIAS_PITCHES (size_t []){ 1,512,1,1,1,1,1,1,1, } 
#define BIAS_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_PER_OUTPUT 0
#define BIAS_PER_OFM 1
#define INPUT0_ELEMENTS_COUNT 512
#define SIMD 16
#define TILE_B 5
#define TILE_OFM 2
#define TILE_IFM 1
#define TILE_K 2
#define TILE_K_OFM 4
#define DISPATCH_BSV 2
#define DISPATCH_FSV 1
#define CONST_LOOP_CALL(macro, idx) macro(idx)
#define CONST_LOOP_1(macro) CONST_LOOP_CALL(macro, 0)
#define CONST_LOOP_2(macro) CONST_LOOP_1(macro); CONST_LOOP_CALL(macro,1)
#define CONST_LOOP_3(macro) CONST_LOOP_2(macro); CONST_LOOP_CALL(macro,2)
#define CONST_LOOP_4(macro) CONST_LOOP_3(macro); CONST_LOOP_CALL(macro,3)
#define CONST_LOOP_5(macro) CONST_LOOP_4(macro); CONST_LOOP_CALL(macro,4)
#define CONST_LOOP(count, macro) CAT(CONST_LOOP_, count)(macro)
#define REALIGN_FP16_OFFSET 0
#define ACTIVATION_TYPE half
#define ACTIVATION_VAL_MAX HALF_MAX
#define ACTIVATION_VAL_MIN -ACTIVATION_VAL_MAX
#define ACTIVATION_VAL_ONE 1.0h
#define ACTIVATION_VAL_ZERO 0.0h
#define TO_ACTIVATION_TYPE(v) convert_half(v)
#define TO_ACTIVATION_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_TYPE(v) as_half(v)
#define ACTIVATION_MAX_FUNC fmax
#define ACTIVATION_MIN_FUNC fmin
#define ACTIVATION_ABS_FUNC fabs
#define ACTIVATION_TYPE_SIZE 2
#define ACTIVATION_IS_FP 1
#define NL_M_TYPED_0 as_float(0x0)/*0.000000e+00*/
#define NL_N_TYPED_0 as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPED_0_TYPE half
#define ACTIVATION_FUNC_TYPED_0_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_TYPED_0_VAL_MIN -ACTIVATION_FUNC_TYPED_0_VAL_MAX
#define ACTIVATION_FUNC_TYPED_0_VAL_ONE 1.0h
#define ACTIVATION_FUNC_TYPED_0_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPED_0_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPED_0_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPED_0_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_TYPED_0_MAX_FUNC fmax
#define ACTIVATION_FUNC_TYPED_0_MIN_FUNC fmin
#define ACTIVATION_FUNC_TYPED_0_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPED_0_TYPE_SIZE 2
#define ACTIVATION_FUNC_TYPED_0_IS_FP 1
#define ACTIVATION_PARAMS_TYPED_0 NL_M_TYPED_0, NL_N_TYPED_0
#define ACTIVATION_FUNC_TYPED_0(input, m, n) (ACTIVATION_FUNC_TYPED_0_MAX_FUNC(ACTIVATION_FUNC_TYPED_0_VAL_ZERO, input))
#define ACTIVATION_TYPED_0(input, params) ACTIVATION_FUNC_TYPED_0(input, params)
#define ACTIVATION_PARAMS_TYPED ACTIVATION_PARAMS_TYPED_0
#define ACTIVATION_TYPED(input, params) ACTIVATION_FUNC_TYPED_0(input, params)
#define ACCUMULATOR_TYPE half
#define ACCUMULATOR_VAL_MAX HALF_MAX
#define ACCUMULATOR_VAL_MIN -ACCUMULATOR_VAL_MAX
#define ACCUMULATOR_VAL_ONE 1.0h
#define ACCUMULATOR_VAL_ZERO 0.0h
#define TO_ACCUMULATOR_TYPE(v) convert_half(v)
#define TO_ACCUMULATOR_TYPE_SAT(v) convert_half(v)
#define AS_ACCUMULATOR_TYPE(v) as_half(v)
#define ACCUMULATOR_MAX_FUNC fmax
#define ACCUMULATOR_MIN_FUNC fmin
#define ACCUMULATOR_ABS_FUNC fabs
#define ACCUMULATOR_TYPE_SIZE 2
#define ACCUMULATOR_IS_FP 1
#define TILE_OUT_F_NUM 512
#define TILE_OUT_F_PITCH 1
#define TILE_IN_B_PITCH 512
#define TILE_OUT_B_PITCH 512
#define BATCH_SIZE (OUTPUT_BATCH_NUM)


#if SIMD != 8 && SIMD != 16
# error "fully_connected_gpu_bf_tiled.cl - SIMD must be one of {8, 16}"
#endif
#if TILE_OFM != 1 && TILE_OFM != 2 && TILE_OFM != 4 && TILE_OFM != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_OFM must be one of {1, 2, 4, 8}"
#endif
#if TILE_IFM != 1 && TILE_IFM != 2 && TILE_IFM != 4 && TILE_IFM != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_IFM must be one of {1, 2, 4, 8}"
#endif
#if TILE_K != 1 && TILE_K != 2 && TILE_K != 4 && TILE_K != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_K must be one of {1, 2, 4, 8}"
#endif
#if TILE_K_OFM != (TILE_K * TILE_OFM) || TILE_K_OFM > 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_K_OFM must be equal to TILE_K * TILE_OFM and at most 8"
#endif
#define INPUT_VEC_TYPE MAKE_VECTOR_TYPE(INPUT0_TYPE, TILE_IFM)
#define ACCUMULATOR_VEC_TYPE MAKE_VECTOR_TYPE(ACCUMULATOR_TYPE, TILE_OFM)
#define FILTER_VEC_TYPE MAKE_VECTOR_TYPE(FILTER_TYPE, TILE_K_OFM)
#define BIAS_VEC_TYPE MAKE_VECTOR_TYPE(BIAS_TYPE, TILE_OFM)
#define OUTPUT_VEC_TYPE MAKE_VECTOR_TYPE(OUTPUT_TYPE, TILE_OFM)
#define ACTIVATION_VEC_TYPE MAKE_VECTOR_TYPE(ACTIVATION_TYPE, TILE_OFM)
#define TO_OUTPUT_VEC_TYPE(x) CAT(convert_, OUTPUT_VEC_TYPE)(x)
#define TO_ACTIVATION_VEC_TYPE(x) CAT(convert_, ACTIVATION_VEC_TYPE)(x)
#define INPUT_BLOCK_READ(ptr, offset) BLOCK_READN(INPUT0_TYPE, TILE_IFM, ptr, offset)
#define FILTER_BLOCK_READ(ptr, offset) BLOCK_READN(FILTER_TYPE, TILE_K_OFM, ptr, offset)
#define BIAS_BLOCK_READ(ptr, offset) BLOCK_READN(BIAS_TYPE, TILE_OFM, ptr, offset)
#define OUTPUT_BLOCK_WRITE(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, TILE_OFM, ptr, offset, val)
#define USE_BLOCK_WRITE ((OUTPUT_TYPE_SIZE * TILE_OUT_B_PITCH) % 16 == 0 && (OUTPUT_TYPE_SIZE * OUTPUT_OFFSET) % 16 == 0)
#if !REALIGN_FP16_OFFSET
# if OUTPUT_3D
# define MAIN_LOOP_ELEMENTS_COUNT INPUT0_SIZE_Y
# else
# define MAIN_LOOP_ELEMENTS_COUNT INPUT0_ELEMENTS_COUNT
# endif
#else
# if OUTPUT_3D
# define MAIN_LOOP_ELEMENTS_COUNT (INPUT0_SIZE_Y - 1)
# else
# define MAIN_LOOP_ELEMENTS_COUNT (INPUT0_ELEMENTS_COUNT - 1)
# endif
#endif
#if OUTPUT_3D
# define INPUT_ELEMENTS_COUNT INPUT0_SIZE_Y
#else
# define INPUT_ELEMENTS_COUNT INPUT0_ELEMENTS_COUNT
#endif
REQD_SUB_GROUP_SIZE(SIMD)
KERNEL(fc)(
 OPTIONAL_SHAPE_INFO_ARG
 const __global INPUT0_TYPE* input,
 __global OUTPUT_TYPE* output,
 const __global FILTER_TYPE* weights
#if BIAS_TERM
 , const __global BIAS_TYPE* biases
#endif
#if HAS_FUSED_OPS_DECLS
 , FUSED_OPS_DECLS
#endif
) {
 uint gid = (uint)get_group_id(0);
 uint sglid = (uint)get_sub_group_local_id();
 uint feature_mini_block = gid % DISPATCH_FSV;
 uint batch_mini_block = gid / DISPATCH_FSV % DISPATCH_BSV;
 uint feature_mega_block = gid / (DISPATCH_FSV * DISPATCH_BSV) % (CEIL_DIV(TILE_OUT_F_NUM, TILE_OFM * SIMD) / DISPATCH_FSV);
 uint batch_mega_block = gid / (DISPATCH_FSV * DISPATCH_BSV * CEIL_DIV(TILE_OUT_F_NUM, TILE_OFM * SIMD) / DISPATCH_FSV);
 uint out_f = (feature_mega_block * DISPATCH_FSV + feature_mini_block) * (TILE_OFM * SIMD);
 uint out_b = ((batch_mega_block * DISPATCH_BSV + batch_mini_block) * TILE_B);
 ACCUMULATOR_VEC_TYPE acc[TILE_B] = { };
 INPUT_VEC_TYPE in_0[TILE_B] = { };
 FILTER_VEC_TYPE wei = 0;
 uint input_offset = out_b * TILE_IN_B_PITCH + INPUT0_OFFSET;
 uint weights_offset = out_f * INPUT_ELEMENTS_COUNT;
#if REALIGN_FP16_OFFSET
 {
 INPUT0_TYPE tmp_input = input[input_offset + get_sub_group_local_id() % TILE_B * TILE_IN_B_PITCH];
 MAKE_VECTOR_TYPE(FILTER_TYPE, TILE_OFM) tmp_wei = BLOCK_READN(FILTER_TYPE, TILE_OFM, weights, weights_offset);
 unroll_for(uint bi = 0; bi < TILE_B; ++bi) {
 acc[bi] = _sub_group_shuffle(tmp_input, bi) * tmp_wei;
 }
 weights_offset += TILE_OFM * SIMD;
 input_offset += 1;
 }
#endif
 uint iterations = MAIN_LOOP_ELEMENTS_COUNT / (TILE_IFM * SIMD);
 __attribute__((opencl_unroll_hint(1)))
 for (uint ni = 0; ni < iterations; ++ni) {
 #define LOAD_IN_0(bi) do { in_0[bi] = INPUT_BLOCK_READ(input, input_offset); input_offset += TILE_IN_B_PITCH; } while (false)
 CONST_LOOP(TILE_B, LOAD_IN_0);
 #undef LOAD_IN_0
 input_offset += TILE_IFM * SIMD - TILE_IN_B_PITCH * TILE_B;
 unroll_for(uint ki = 0; ki < (TILE_IFM * SIMD) / TILE_K; ++ki) {
 wei = FILTER_BLOCK_READ(weights, weights_offset);
 weights_offset += TILE_K_OFM * SIMD;
 unroll_for (uint kii = 0; kii < TILE_K; ++kii) {
 const uint total_k = ki * TILE_K + kii;
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 INPUT0_TYPE in_val = _sub_group_shuffle(((INPUT0_TYPE*)(&in_0[bi]))[total_k / SIMD], total_k % SIMD);
 unroll_for (uint fi = 0; fi < TILE_OFM; ++fi) {
 ((ACCUMULATOR_TYPE*)(&acc[bi]))[fi] += in_val * ((FILTER_TYPE*)(&wei))[kii * TILE_OFM + fi];
 }
 }
 }
 }
 }
#if MAIN_LOOP_ELEMENTS_COUNT % (TILE_IFM * SIMD) != 0
 #define LEFTOVER_IFM (MAIN_LOOP_ELEMENTS_COUNT % (TILE_IFM * SIMD))
 {
 #define LOAD_IN_0(bi) do { in_0[bi] = INPUT_BLOCK_READ(input, input_offset); input_offset += TILE_IN_B_PITCH; } while (false)
 CONST_LOOP(TILE_B, LOAD_IN_0);
 #undef LOAD_IN_0
 input_offset += TILE_IFM * SIMD - TILE_IN_B_PITCH * TILE_B;
 unroll_for(uint ki = 0; ki < CEIL_DIV(LEFTOVER_IFM, TILE_K); ++ki) {
 wei = FILTER_BLOCK_READ(weights, weights_offset);
 weights_offset += TILE_K_OFM * SIMD;
 unroll_for (uint kii = 0; kii < TILE_K; ++kii) {
 unroll_for (uint fi = 0; fi < TILE_OFM; ++fi) {
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 const uint total_k = ki * TILE_K + kii;
 if (total_k < LEFTOVER_IFM) {
 INPUT0_TYPE in_val = _sub_group_shuffle(((INPUT0_TYPE*)(&in_0[bi]))[total_k / SIMD], total_k % SIMD);
 ((ACCUMULATOR_TYPE*)(&acc[bi]))[fi] += in_val * ((FILTER_TYPE*)(&wei))[kii * TILE_OFM + fi];
 }
 }
 }
 }
 }
 }
 #undef LEFTOVER_IFM
#endif
 ACTIVATION_VEC_TYPE activated[TILE_B] = { };
 for (uint bi = 0; bi < TILE_B; ++bi) {
 activated[bi] = TO_ACTIVATION_VEC_TYPE(acc[bi]);
 }
#if BIAS_TERM
 #if TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0
 BIAS_VEC_TYPE bias = BIAS_BLOCK_READ(biases, out_f);
 #else
 BIAS_VEC_TYPE bias = 0;
 unroll_for(uint fi = 0; fi < TILE_OFM; ++fi) {
 ((BIAS_TYPE*)(&bias))[fi] = biases[out_f + sglid + fi * SIMD];
 }
 #endif
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 activated[bi] += TO_ACTIVATION_VEC_TYPE(bias);
 }
#endif
 OUTPUT_VEC_TYPE result[TILE_B] = { };
#if HAS_FUSED_OPS
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 #if TILE_OFM > 1
 unroll_for(uint fi = 0; fi < TILE_OFM; ++fi) {
 FUSED_OPS_VEC;
 result[bi][fi] = FUSED_OPS_RESULT_VEC;
 }
 #else
 FUSED_OPS_SCALAR;
 result[bi] = FUSED_OPS_RESULT_SCALAR;
 #endif
 }
#else
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 result[bi] = TO_OUTPUT_VEC_TYPE(ACTIVATION_TYPED(activated[bi], ACTIVATION_PARAMS_TYPED));
 }
#endif
 uint output_offset = out_f * TILE_OUT_F_PITCH + out_b * TILE_OUT_B_PITCH + OUTPUT_OFFSET;
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
#if IS_DYNAMIC
 #define WRITE_OUTPUT(bi) do { if (bi + out_b < BATCH_SIZE) OUTPUT_BLOCK_WRITE(output, output_offset, result[bi]); output_offset += TILE_OUT_B_PITCH; } while (false)
#else
 #define WRITE_OUTPUT(bi) do { OUTPUT_BLOCK_WRITE(output, output_offset, result[bi]); output_offset += TILE_OUT_B_PITCH; } while (false)
#endif
 CONST_LOOP(TILE_B, WRITE_OUTPUT);
 #undef WRITE_OUTPUT
 } else {
 output_offset += sglid;
 for (uint bi = 0; bi < TILE_B; ++bi) {
 for (uint fi = 0; fi < TILE_OFM; ++fi) {
 const bool should_write =
#if IS_DYNAMIC
 bi + out_b < BATCH_SIZE &&
#endif
 (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 ||
 out_f + fi * SIMD + sglid < TILE_OUT_F_NUM);
 if (should_write) {
 output[output_offset] = ((OUTPUT_TYPE*)(&result[bi]))[fi];
 }
 output_offset += SIMD;
 }
 output_offset += TILE_OUT_B_PITCH - TILE_OFM * SIMD;
 }
 }
}
#undef INPUT_VEC_TYPE
#undef ACCUMULATOR_VEC_TYPE
#undef FILTER_VEC_TYPE
#undef BIAS_VEC_TYPE
#undef OUTPUT_VEC_TYPE
#undef ACTIVATION_VEC_TYPE
#undef TO_OUTPUT_VEC_TYPE
#undef TO_ACTIVATION_VEC_TYPE
#undef INPUT_BLOCK_READ
#undef FILTER_BLOCK_READ
#undef BIAS_BLOCK_READ
#undef OUTPUT_BLOCK_WRITE
#undef USE_BLOCK_WRITE
#undef MAIN_LOOP_ELEMENTS_COUNT
#ifdef INPUT_VEC_TYPE
#undef INPUT_VEC_TYPE
#endif
#ifdef ACCUMULATOR_VEC_TYPE
#undef ACCUMULATOR_VEC_TYPE
#endif
#ifdef FILTER_VEC_TYPE
#undef FILTER_VEC_TYPE
#endif
#ifdef BIAS_VEC_TYPE
#undef BIAS_VEC_TYPE
#endif
#ifdef OUTPUT_VEC_TYPE
#undef OUTPUT_VEC_TYPE
#endif
#ifdef ACTIVATION_VEC_TYPE
#undef ACTIVATION_VEC_TYPE
#endif
#ifdef TO_OUTPUT_VEC_TYPE
#undef TO_OUTPUT_VEC_TYPE
#endif
#ifdef TO_ACTIVATION_VEC_TYPE
#undef TO_ACTIVATION_VEC_TYPE
#endif
#ifdef INPUT_BLOCK_READ
#undef INPUT_BLOCK_READ
#endif
#ifdef FILTER_BLOCK_READ
#undef FILTER_BLOCK_READ
#endif
#ifdef BIAS_BLOCK_READ
#undef BIAS_BLOCK_READ
#endif
#ifdef OUTPUT_BLOCK_WRITE
#undef OUTPUT_BLOCK_WRITE
#endif
#ifdef USE_BLOCK_WRITE
#undef USE_BLOCK_WRITE
#endif
#ifdef LOAD_IN_0
#undef LOAD_IN_0
#endif
#ifdef LEFTOVER_IFM
#undef LEFTOVER_IFM
#endif
#ifdef LOAD_IN_0
#undef LOAD_IN_0
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#ifdef WRITE_OUTPUT_FEATURE
#undef WRITE_OUTPUT_FEATURE
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#undef KERNEL
#undef FUNC
#undef FUNC_CALL
#undef CONST_ARRAY_DECL
#undef CONST_ARRAY_REF
#ifdef FP64_SUPPORTED
#undef FP64_SUPPORTED
#endif
#ifdef FP16_SUPPORTED
#undef FP16_SUPPORTED
#endif
#ifdef FP16_UNIT_USED
#undef FP16_UNIT_USED
#endif
#ifdef INT8_UNIT_USED
#undef INT8_UNIT_USED
#endif
#ifdef INT32_UNIT_USED
#undef INT32_UNIT_USED
#endif
#ifdef INT64_UNIT_USED
#undef INT64_UNIT_USED
#endif
#ifdef UINT8_UNIT_USED
#undef UINT8_UNIT_USED
#endif
#ifdef UINT32_UNIT_USED
#undef UINT32_UNIT_USED
#endif
#ifdef UNIT_TYPE
#undef UNIT_TYPE
#endif
#ifdef UNIT_VAL_MAX
#undef UNIT_VAL_MAX
#endif
#ifdef UNIT_VAL_MIN
#undef UNIT_VAL_MIN
#endif
#ifdef UNIT_VAL_ONE
#undef UNIT_VAL_ONE
#endif
#ifdef UNIT_VAL_ZERO
#undef UNIT_VAL_ZERO
#endif
#ifdef TO_UNIT_TYPE
#undef TO_UNIT_TYPE
#endif
#ifdef TO_UNIT_TYPE_SAT
#undef TO_UNIT_TYPE_SAT
#endif
#ifdef AS_UNIT_TYPE
#undef AS_UNIT_TYPE
#endif
#ifdef UNIT_MAX_FUNC
#undef UNIT_MAX_FUNC
#endif
#ifdef UNIT_MIN_FUNC
#undef UNIT_MIN_FUNC
#endif
#ifdef UNIT_ABS_FUNC
#undef UNIT_ABS_FUNC
#endif
#ifdef UNIT_TYPE_SIZE
#undef UNIT_TYPE_SIZE
#endif
#ifdef UNIT_IS_FP
#undef UNIT_IS_FP
#endif
#ifdef NL_M_0
#undef NL_M_0
#endif
#ifdef NL_N_0
#undef NL_N_0
#endif
#ifdef ACTIVATION_FUNC_0_TYPE
#undef ACTIVATION_FUNC_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_0_VAL_MAX
#undef ACTIVATION_FUNC_0_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_0_VAL_MIN
#undef ACTIVATION_FUNC_0_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_0_VAL_ONE
#undef ACTIVATION_FUNC_0_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_0_VAL_ZERO
#undef ACTIVATION_FUNC_0_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_0_TYPE
#undef TO_ACTIVATION_FUNC_0_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_0_TYPE_SAT
#undef TO_ACTIVATION_FUNC_0_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_0_TYPE
#undef AS_ACTIVATION_FUNC_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_0_MAX_FUNC
#undef ACTIVATION_FUNC_0_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_0_MIN_FUNC
#undef ACTIVATION_FUNC_0_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_0_ABS_FUNC
#undef ACTIVATION_FUNC_0_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_0_TYPE_SIZE
#undef ACTIVATION_FUNC_0_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_0_IS_FP
#undef ACTIVATION_FUNC_0_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_0
#undef ACTIVATION_PARAMS_0
#endif
#ifdef ACTIVATION_FUNC_0
#undef ACTIVATION_FUNC_0
#endif
#ifdef ACTIVATION_0
#undef ACTIVATION_0
#endif
#ifdef ACTIVATION_PARAMS
#undef ACTIVATION_PARAMS
#endif
#ifdef ACTIVATION
#undef ACTIVATION
#endif
#ifdef INPUT0_SIZE_X
#undef INPUT0_SIZE_X
#endif
#ifdef INPUT0_SIZE_Y
#undef INPUT0_SIZE_Y
#endif
#ifdef INPUT0_SIZE_Z
#undef INPUT0_SIZE_Z
#endif
#ifdef INPUT0_SIZE_W
#undef INPUT0_SIZE_W
#endif
#ifdef INPUT0_SIZE_U
#undef INPUT0_SIZE_U
#endif
#ifdef INPUT0_SIZE_V
#undef INPUT0_SIZE_V
#endif
#ifdef INPUT0_FEATURE_NUM
#undef INPUT0_FEATURE_NUM
#endif
#ifdef INPUT0_BATCH_NUM
#undef INPUT0_BATCH_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_X
#undef INPUT0_PAD_BEFORE_SIZE_X
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Y
#undef INPUT0_PAD_BEFORE_SIZE_Y
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Z
#undef INPUT0_PAD_BEFORE_SIZE_Z
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_W
#undef INPUT0_PAD_BEFORE_SIZE_W
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_U
#undef INPUT0_PAD_BEFORE_SIZE_U
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_V
#undef INPUT0_PAD_BEFORE_SIZE_V
#endif
#ifdef INPUT0_PAD_BEFORE_FEATURE_NUM
#undef INPUT0_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_BATCH_NUM
#undef INPUT0_PAD_BEFORE_BATCH_NUM
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_X
#undef INPUT0_PAD_AFTER_SIZE_X
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Y
#undef INPUT0_PAD_AFTER_SIZE_Y
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Z
#undef INPUT0_PAD_AFTER_SIZE_Z
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_W
#undef INPUT0_PAD_AFTER_SIZE_W
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_U
#undef INPUT0_PAD_AFTER_SIZE_U
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_V
#undef INPUT0_PAD_AFTER_SIZE_V
#endif
#ifdef INPUT0_PAD_AFTER_FEATURE_NUM
#undef INPUT0_PAD_AFTER_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_AFTER_BATCH_NUM
#undef INPUT0_PAD_AFTER_BATCH_NUM
#endif
#ifdef INPUT0_X_PITCH
#undef INPUT0_X_PITCH
#endif
#ifdef INPUT0_Y_PITCH
#undef INPUT0_Y_PITCH
#endif
#ifdef INPUT0_Z_PITCH
#undef INPUT0_Z_PITCH
#endif
#ifdef INPUT0_W_PITCH
#undef INPUT0_W_PITCH
#endif
#ifdef INPUT0_U_PITCH
#undef INPUT0_U_PITCH
#endif
#ifdef INPUT0_V_PITCH
#undef INPUT0_V_PITCH
#endif
#ifdef INPUT0_FEATURE_PITCH
#undef INPUT0_FEATURE_PITCH
#endif
#ifdef INPUT0_BATCH_PITCH
#undef INPUT0_BATCH_PITCH
#endif
#ifdef INPUT0_GET_INDEX_SAFE
#undef INPUT0_GET_INDEX_SAFE
#endif
#ifdef INPUT0_GET_INDEX
#undef INPUT0_GET_INDEX
#endif
#ifdef INPUT0_GET_INDEX_RAW
#undef INPUT0_GET_INDEX_RAW
#endif
#ifdef INPUT0_VIEW_OFFSET
#undef INPUT0_VIEW_OFFSET
#endif
#ifdef INPUT0_LENGTH
#undef INPUT0_LENGTH
#endif
#ifdef INPUT0_DIMS
#undef INPUT0_DIMS
#endif
#ifdef INPUT0_SIMPLE
#undef INPUT0_SIMPLE
#endif
#ifdef INPUT0_GROUPED
#undef INPUT0_GROUPED
#endif
#ifdef INPUT0_LAYOUT_BFYX
#undef INPUT0_LAYOUT_BFYX
#endif
#ifdef INPUT0_TYPE
#undef INPUT0_TYPE
#endif
#ifdef INPUT0_VAL_MAX
#undef INPUT0_VAL_MAX
#endif
#ifdef INPUT0_VAL_MIN
#undef INPUT0_VAL_MIN
#endif
#ifdef INPUT0_VAL_ONE
#undef INPUT0_VAL_ONE
#endif
#ifdef INPUT0_VAL_ZERO
#undef INPUT0_VAL_ZERO
#endif
#ifdef TO_INPUT0_TYPE
#undef TO_INPUT0_TYPE
#endif
#ifdef TO_INPUT0_TYPE_SAT
#undef TO_INPUT0_TYPE_SAT
#endif
#ifdef AS_INPUT0_TYPE
#undef AS_INPUT0_TYPE
#endif
#ifdef INPUT0_MAX_FUNC
#undef INPUT0_MAX_FUNC
#endif
#ifdef INPUT0_MIN_FUNC
#undef INPUT0_MIN_FUNC
#endif
#ifdef INPUT0_ABS_FUNC
#undef INPUT0_ABS_FUNC
#endif
#ifdef INPUT0_TYPE_SIZE
#undef INPUT0_TYPE_SIZE
#endif
#ifdef INPUT0_IS_FP
#undef INPUT0_IS_FP
#endif
#ifdef INPUT0_OFFSET
#undef INPUT0_OFFSET
#endif
#ifdef INPUT0_SIZES_DATA
#undef INPUT0_SIZES_DATA
#endif
#ifdef INPUT0_PITCHES
#undef INPUT0_PITCHES
#endif
#ifdef INPUT0_PAD_BEFORE
#undef INPUT0_PAD_BEFORE
#endif
#ifdef INPUT0_PAD_AFTER
#undef INPUT0_PAD_AFTER
#endif
#ifdef OUTPUT_SIZE_X
#undef OUTPUT_SIZE_X
#endif
#ifdef OUTPUT_SIZE_Y
#undef OUTPUT_SIZE_Y
#endif
#ifdef OUTPUT_SIZE_Z
#undef OUTPUT_SIZE_Z
#endif
#ifdef OUTPUT_SIZE_W
#undef OUTPUT_SIZE_W
#endif
#ifdef OUTPUT_SIZE_U
#undef OUTPUT_SIZE_U
#endif
#ifdef OUTPUT_SIZE_V
#undef OUTPUT_SIZE_V
#endif
#ifdef OUTPUT_FEATURE_NUM
#undef OUTPUT_FEATURE_NUM
#endif
#ifdef OUTPUT_BATCH_NUM
#undef OUTPUT_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_X
#undef OUTPUT_PAD_BEFORE_SIZE_X
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Y
#undef OUTPUT_PAD_BEFORE_SIZE_Y
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Z
#undef OUTPUT_PAD_BEFORE_SIZE_Z
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_W
#undef OUTPUT_PAD_BEFORE_SIZE_W
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_U
#undef OUTPUT_PAD_BEFORE_SIZE_U
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_V
#undef OUTPUT_PAD_BEFORE_SIZE_V
#endif
#ifdef OUTPUT_PAD_BEFORE_FEATURE_NUM
#undef OUTPUT_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_BATCH_NUM
#undef OUTPUT_PAD_BEFORE_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_X
#undef OUTPUT_PAD_AFTER_SIZE_X
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Y
#undef OUTPUT_PAD_AFTER_SIZE_Y
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Z
#undef OUTPUT_PAD_AFTER_SIZE_Z
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_W
#undef OUTPUT_PAD_AFTER_SIZE_W
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_U
#undef OUTPUT_PAD_AFTER_SIZE_U
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_V
#undef OUTPUT_PAD_AFTER_SIZE_V
#endif
#ifdef OUTPUT_PAD_AFTER_FEATURE_NUM
#undef OUTPUT_PAD_AFTER_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_BATCH_NUM
#undef OUTPUT_PAD_AFTER_BATCH_NUM
#endif
#ifdef OUTPUT_X_PITCH
#undef OUTPUT_X_PITCH
#endif
#ifdef OUTPUT_Y_PITCH
#undef OUTPUT_Y_PITCH
#endif
#ifdef OUTPUT_Z_PITCH
#undef OUTPUT_Z_PITCH
#endif
#ifdef OUTPUT_W_PITCH
#undef OUTPUT_W_PITCH
#endif
#ifdef OUTPUT_U_PITCH
#undef OUTPUT_U_PITCH
#endif
#ifdef OUTPUT_V_PITCH
#undef OUTPUT_V_PITCH
#endif
#ifdef OUTPUT_FEATURE_PITCH
#undef OUTPUT_FEATURE_PITCH
#endif
#ifdef OUTPUT_BATCH_PITCH
#undef OUTPUT_BATCH_PITCH
#endif
#ifdef OUTPUT_GET_INDEX_SAFE
#undef OUTPUT_GET_INDEX_SAFE
#endif
#ifdef OUTPUT_GET_INDEX
#undef OUTPUT_GET_INDEX
#endif
#ifdef OUTPUT_GET_INDEX_RAW
#undef OUTPUT_GET_INDEX_RAW
#endif
#ifdef OUTPUT_VIEW_OFFSET
#undef OUTPUT_VIEW_OFFSET
#endif
#ifdef OUTPUT_LENGTH
#undef OUTPUT_LENGTH
#endif
#ifdef OUTPUT_DIMS
#undef OUTPUT_DIMS
#endif
#ifdef OUTPUT_SIMPLE
#undef OUTPUT_SIMPLE
#endif
#ifdef OUTPUT_GROUPED
#undef OUTPUT_GROUPED
#endif
#ifdef OUTPUT_LAYOUT_BF
#undef OUTPUT_LAYOUT_BF
#endif
#ifdef OUTPUT_TYPE
#undef OUTPUT_TYPE
#endif
#ifdef OUTPUT_VAL_MAX
#undef OUTPUT_VAL_MAX
#endif
#ifdef OUTPUT_VAL_MIN
#undef OUTPUT_VAL_MIN
#endif
#ifdef OUTPUT_VAL_ONE
#undef OUTPUT_VAL_ONE
#endif
#ifdef OUTPUT_VAL_ZERO
#undef OUTPUT_VAL_ZERO
#endif
#ifdef TO_OUTPUT_TYPE
#undef TO_OUTPUT_TYPE
#endif
#ifdef TO_OUTPUT_TYPE_SAT
#undef TO_OUTPUT_TYPE_SAT
#endif
#ifdef AS_OUTPUT_TYPE
#undef AS_OUTPUT_TYPE
#endif
#ifdef OUTPUT_MAX_FUNC
#undef OUTPUT_MAX_FUNC
#endif
#ifdef OUTPUT_MIN_FUNC
#undef OUTPUT_MIN_FUNC
#endif
#ifdef OUTPUT_ABS_FUNC
#undef OUTPUT_ABS_FUNC
#endif
#ifdef OUTPUT_TYPE_SIZE
#undef OUTPUT_TYPE_SIZE
#endif
#ifdef OUTPUT_IS_FP
#undef OUTPUT_IS_FP
#endif
#ifdef OUTPUT_OFFSET
#undef OUTPUT_OFFSET
#endif
#ifdef OUTPUT_SIZES_DATA
#undef OUTPUT_SIZES_DATA
#endif
#ifdef OUTPUT_PITCHES
#undef OUTPUT_PITCHES
#endif
#ifdef OUTPUT_PAD_BEFORE
#undef OUTPUT_PAD_BEFORE
#endif
#ifdef OUTPUT_PAD_AFTER
#undef OUTPUT_PAD_AFTER
#endif
#ifdef OPTIONAL_SHAPE_INFO_ARG
#undef OPTIONAL_SHAPE_INFO_ARG
#endif
#ifdef OPTIONAL_SHAPE_INFO_TENSOR
#undef OPTIONAL_SHAPE_INFO_TENSOR
#endif
#ifdef FILTER_SIZE_X
#undef FILTER_SIZE_X
#endif
#ifdef FILTER_SIZE_Y
#undef FILTER_SIZE_Y
#endif
#ifdef FILTER_SIZE_Z
#undef FILTER_SIZE_Z
#endif
#ifdef FILTER_IFM_NUM
#undef FILTER_IFM_NUM
#endif
#ifdef FILTER_OFM_NUM
#undef FILTER_OFM_NUM
#endif
#ifdef FILTER_GROUPS_NUM
#undef FILTER_GROUPS_NUM
#endif
#ifdef FILTER_X_PITCH
#undef FILTER_X_PITCH
#endif
#ifdef FILTER_Y_PITCH
#undef FILTER_Y_PITCH
#endif
#ifdef FILTER_Z_PITCH
#undef FILTER_Z_PITCH
#endif
#ifdef FILTER_IFM_PITCH
#undef FILTER_IFM_PITCH
#endif
#ifdef FILTER_OFM_PITCH
#undef FILTER_OFM_PITCH
#endif
#ifdef FILTER_GROUPS_PITCH
#undef FILTER_GROUPS_PITCH
#endif
#ifdef FILTER_VIEW_OFFSET
#undef FILTER_VIEW_OFFSET
#endif
#ifdef FILTER_LENGTH
#undef FILTER_LENGTH
#endif
#ifdef FILTER_DIMS
#undef FILTER_DIMS
#endif
#ifdef FILTER_SIMPLE
#undef FILTER_SIMPLE
#endif
#ifdef FILTER_GROUPED
#undef FILTER_GROUPED
#endif
#ifdef FILTER_LAYOUT_OS_IYX_OSV32
#undef FILTER_LAYOUT_OS_IYX_OSV32
#endif
#ifdef FILTER_TYPE
#undef FILTER_TYPE
#endif
#ifdef FILTER_VAL_MAX
#undef FILTER_VAL_MAX
#endif
#ifdef FILTER_VAL_MIN
#undef FILTER_VAL_MIN
#endif
#ifdef FILTER_VAL_ONE
#undef FILTER_VAL_ONE
#endif
#ifdef FILTER_VAL_ZERO
#undef FILTER_VAL_ZERO
#endif
#ifdef TO_FILTER_TYPE
#undef TO_FILTER_TYPE
#endif
#ifdef TO_FILTER_TYPE_SAT
#undef TO_FILTER_TYPE_SAT
#endif
#ifdef AS_FILTER_TYPE
#undef AS_FILTER_TYPE
#endif
#ifdef FILTER_MAX_FUNC
#undef FILTER_MAX_FUNC
#endif
#ifdef FILTER_MIN_FUNC
#undef FILTER_MIN_FUNC
#endif
#ifdef FILTER_ABS_FUNC
#undef FILTER_ABS_FUNC
#endif
#ifdef FILTER_TYPE_SIZE
#undef FILTER_TYPE_SIZE
#endif
#ifdef FILTER_IS_FP
#undef FILTER_IS_FP
#endif
#ifdef FILTER_OFFSET
#undef FILTER_OFFSET
#endif
#ifdef FILTER_SIZES_DATA
#undef FILTER_SIZES_DATA
#endif
#ifdef FILTER_PITCHES
#undef FILTER_PITCHES
#endif
#ifdef FILTER_PAD_BEFORE
#undef FILTER_PAD_BEFORE
#endif
#ifdef FILTER_PAD_AFTER
#undef FILTER_PAD_AFTER
#endif
#ifdef BIAS_TERM
#undef BIAS_TERM
#endif
#ifdef BIAS_SIZE_X
#undef BIAS_SIZE_X
#endif
#ifdef BIAS_SIZE_Y
#undef BIAS_SIZE_Y
#endif
#ifdef BIAS_SIZE_Z
#undef BIAS_SIZE_Z
#endif
#ifdef BIAS_SIZE_W
#undef BIAS_SIZE_W
#endif
#ifdef BIAS_SIZE_U
#undef BIAS_SIZE_U
#endif
#ifdef BIAS_SIZE_V
#undef BIAS_SIZE_V
#endif
#ifdef BIAS_FEATURE_NUM
#undef BIAS_FEATURE_NUM
#endif
#ifdef BIAS_BATCH_NUM
#undef BIAS_BATCH_NUM
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_X
#undef BIAS_PAD_BEFORE_SIZE_X
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_Y
#undef BIAS_PAD_BEFORE_SIZE_Y
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_Z
#undef BIAS_PAD_BEFORE_SIZE_Z
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_W
#undef BIAS_PAD_BEFORE_SIZE_W
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_U
#undef BIAS_PAD_BEFORE_SIZE_U
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_V
#undef BIAS_PAD_BEFORE_SIZE_V
#endif
#ifdef BIAS_PAD_BEFORE_FEATURE_NUM
#undef BIAS_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef BIAS_PAD_BEFORE_BATCH_NUM
#undef BIAS_PAD_BEFORE_BATCH_NUM
#endif
#ifdef BIAS_PAD_AFTER_SIZE_X
#undef BIAS_PAD_AFTER_SIZE_X
#endif
#ifdef BIAS_PAD_AFTER_SIZE_Y
#undef BIAS_PAD_AFTER_SIZE_Y
#endif
#ifdef BIAS_PAD_AFTER_SIZE_Z
#undef BIAS_PAD_AFTER_SIZE_Z
#endif
#ifdef BIAS_PAD_AFTER_SIZE_W
#undef BIAS_PAD_AFTER_SIZE_W
#endif
#ifdef BIAS_PAD_AFTER_SIZE_U
#undef BIAS_PAD_AFTER_SIZE_U
#endif
#ifdef BIAS_PAD_AFTER_SIZE_V
#undef BIAS_PAD_AFTER_SIZE_V
#endif
#ifdef BIAS_PAD_AFTER_FEATURE_NUM
#undef BIAS_PAD_AFTER_FEATURE_NUM
#endif
#ifdef BIAS_PAD_AFTER_BATCH_NUM
#undef BIAS_PAD_AFTER_BATCH_NUM
#endif
#ifdef BIAS_X_PITCH
#undef BIAS_X_PITCH
#endif
#ifdef BIAS_Y_PITCH
#undef BIAS_Y_PITCH
#endif
#ifdef BIAS_Z_PITCH
#undef BIAS_Z_PITCH
#endif
#ifdef BIAS_W_PITCH
#undef BIAS_W_PITCH
#endif
#ifdef BIAS_U_PITCH
#undef BIAS_U_PITCH
#endif
#ifdef BIAS_V_PITCH
#undef BIAS_V_PITCH
#endif
#ifdef BIAS_FEATURE_PITCH
#undef BIAS_FEATURE_PITCH
#endif
#ifdef BIAS_BATCH_PITCH
#undef BIAS_BATCH_PITCH
#endif
#ifdef BIAS_GET_INDEX_SAFE
#undef BIAS_GET_INDEX_SAFE
#endif
#ifdef BIAS_GET_INDEX
#undef BIAS_GET_INDEX
#endif
#ifdef BIAS_GET_INDEX_RAW
#undef BIAS_GET_INDEX_RAW
#endif
#ifdef BIAS_VIEW_OFFSET
#undef BIAS_VIEW_OFFSET
#endif
#ifdef BIAS_LENGTH
#undef BIAS_LENGTH
#endif
#ifdef BIAS_DIMS
#undef BIAS_DIMS
#endif
#ifdef BIAS_SIMPLE
#undef BIAS_SIMPLE
#endif
#ifdef BIAS_GROUPED
#undef BIAS_GROUPED
#endif
#ifdef BIAS_LAYOUT_BF
#undef BIAS_LAYOUT_BF
#endif
#ifdef BIAS_TYPE
#undef BIAS_TYPE
#endif
#ifdef BIAS_VAL_MAX
#undef BIAS_VAL_MAX
#endif
#ifdef BIAS_VAL_MIN
#undef BIAS_VAL_MIN
#endif
#ifdef BIAS_VAL_ONE
#undef BIAS_VAL_ONE
#endif
#ifdef BIAS_VAL_ZERO
#undef BIAS_VAL_ZERO
#endif
#ifdef TO_BIAS_TYPE
#undef TO_BIAS_TYPE
#endif
#ifdef TO_BIAS_TYPE_SAT
#undef TO_BIAS_TYPE_SAT
#endif
#ifdef AS_BIAS_TYPE
#undef AS_BIAS_TYPE
#endif
#ifdef BIAS_MAX_FUNC
#undef BIAS_MAX_FUNC
#endif
#ifdef BIAS_MIN_FUNC
#undef BIAS_MIN_FUNC
#endif
#ifdef BIAS_ABS_FUNC
#undef BIAS_ABS_FUNC
#endif
#ifdef BIAS_TYPE_SIZE
#undef BIAS_TYPE_SIZE
#endif
#ifdef BIAS_IS_FP
#undef BIAS_IS_FP
#endif
#ifdef BIAS_OFFSET
#undef BIAS_OFFSET
#endif
#ifdef BIAS_SIZES_DATA
#undef BIAS_SIZES_DATA
#endif
#ifdef BIAS_PITCHES
#undef BIAS_PITCHES
#endif
#ifdef BIAS_PAD_BEFORE
#undef BIAS_PAD_BEFORE
#endif
#ifdef BIAS_PAD_AFTER
#undef BIAS_PAD_AFTER
#endif
#ifdef BIAS_PER_OUTPUT
#undef BIAS_PER_OUTPUT
#endif
#ifdef BIAS_PER_OFM
#undef BIAS_PER_OFM
#endif
#ifdef INPUT0_ELEMENTS_COUNT
#undef INPUT0_ELEMENTS_COUNT
#endif
#ifdef SIMD
#undef SIMD
#endif
#ifdef TILE_B
#undef TILE_B
#endif
#ifdef TILE_OFM
#undef TILE_OFM
#endif
#ifdef TILE_IFM
#undef TILE_IFM
#endif
#ifdef TILE_K
#undef TILE_K
#endif
#ifdef TILE_K_OFM
#undef TILE_K_OFM
#endif
#ifdef DISPATCH_BSV
#undef DISPATCH_BSV
#endif
#ifdef DISPATCH_FSV
#undef DISPATCH_FSV
#endif
#ifdef CONST_LOOP_CALL
#undef CONST_LOOP_CALL
#endif
#ifdef CONST_LOOP_1
#undef CONST_LOOP_1
#endif
#ifdef CONST_LOOP_2
#undef CONST_LOOP_2
#endif
#ifdef CONST_LOOP_3
#undef CONST_LOOP_3
#endif
#ifdef CONST_LOOP_4
#undef CONST_LOOP_4
#endif
#ifdef CONST_LOOP_5
#undef CONST_LOOP_5
#endif
#ifdef CONST_LOOP
#undef CONST_LOOP
#endif
#ifdef REALIGN_FP16_OFFSET
#undef REALIGN_FP16_OFFSET
#endif
#ifdef ACTIVATION_TYPE
#undef ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_VAL_MAX
#undef ACTIVATION_VAL_MAX
#endif
#ifdef ACTIVATION_VAL_MIN
#undef ACTIVATION_VAL_MIN
#endif
#ifdef ACTIVATION_VAL_ONE
#undef ACTIVATION_VAL_ONE
#endif
#ifdef ACTIVATION_VAL_ZERO
#undef ACTIVATION_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_TYPE
#undef TO_ACTIVATION_TYPE
#endif
#ifdef TO_ACTIVATION_TYPE_SAT
#undef TO_ACTIVATION_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_TYPE
#undef AS_ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_MAX_FUNC
#undef ACTIVATION_MAX_FUNC
#endif
#ifdef ACTIVATION_MIN_FUNC
#undef ACTIVATION_MIN_FUNC
#endif
#ifdef ACTIVATION_ABS_FUNC
#undef ACTIVATION_ABS_FUNC
#endif
#ifdef ACTIVATION_TYPE_SIZE
#undef ACTIVATION_TYPE_SIZE
#endif
#ifdef ACTIVATION_IS_FP
#undef ACTIVATION_IS_FP
#endif
#ifdef NL_M_TYPED_0
#undef NL_M_TYPED_0
#endif
#ifdef NL_N_TYPED_0
#undef NL_N_TYPED_0
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_TYPE
#undef ACTIVATION_FUNC_TYPED_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_MAX
#undef ACTIVATION_FUNC_TYPED_0_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_MIN
#undef ACTIVATION_FUNC_TYPED_0_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_ONE
#undef ACTIVATION_FUNC_TYPED_0_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_ZERO
#undef ACTIVATION_FUNC_TYPED_0_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_0_TYPE
#undef TO_ACTIVATION_FUNC_TYPED_0_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_0_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPED_0_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPED_0_TYPE
#undef AS_ACTIVATION_FUNC_TYPED_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_MAX_FUNC
#undef ACTIVATION_FUNC_TYPED_0_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_MIN_FUNC
#undef ACTIVATION_FUNC_TYPED_0_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_ABS_FUNC
#undef ACTIVATION_FUNC_TYPED_0_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPED_0_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_IS_FP
#undef ACTIVATION_FUNC_TYPED_0_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_TYPED_0
#undef ACTIVATION_PARAMS_TYPED_0
#endif
#ifdef ACTIVATION_FUNC_TYPED_0
#undef ACTIVATION_FUNC_TYPED_0
#endif
#ifdef ACTIVATION_TYPED_0
#undef ACTIVATION_TYPED_0
#endif
#ifdef ACTIVATION_PARAMS_TYPED
#undef ACTIVATION_PARAMS_TYPED
#endif
#ifdef ACTIVATION_TYPED
#undef ACTIVATION_TYPED
#endif
#ifdef ACCUMULATOR_TYPE
#undef ACCUMULATOR_TYPE
#endif
#ifdef ACCUMULATOR_VAL_MAX
#undef ACCUMULATOR_VAL_MAX
#endif
#ifdef ACCUMULATOR_VAL_MIN
#undef ACCUMULATOR_VAL_MIN
#endif
#ifdef ACCUMULATOR_VAL_ONE
#undef ACCUMULATOR_VAL_ONE
#endif
#ifdef ACCUMULATOR_VAL_ZERO
#undef ACCUMULATOR_VAL_ZERO
#endif
#ifdef TO_ACCUMULATOR_TYPE
#undef TO_ACCUMULATOR_TYPE
#endif
#ifdef TO_ACCUMULATOR_TYPE_SAT
#undef TO_ACCUMULATOR_TYPE_SAT
#endif
#ifdef AS_ACCUMULATOR_TYPE
#undef AS_ACCUMULATOR_TYPE
#endif
#ifdef ACCUMULATOR_MAX_FUNC
#undef ACCUMULATOR_MAX_FUNC
#endif
#ifdef ACCUMULATOR_MIN_FUNC
#undef ACCUMULATOR_MIN_FUNC
#endif
#ifdef ACCUMULATOR_ABS_FUNC
#undef ACCUMULATOR_ABS_FUNC
#endif
#ifdef ACCUMULATOR_TYPE_SIZE
#undef ACCUMULATOR_TYPE_SIZE
#endif
#ifdef ACCUMULATOR_IS_FP
#undef ACCUMULATOR_IS_FP
#endif
#ifdef TILE_OUT_F_NUM
#undef TILE_OUT_F_NUM
#endif
#ifdef TILE_OUT_F_PITCH
#undef TILE_OUT_F_PITCH
#endif
#ifdef TILE_IN_B_PITCH
#undef TILE_IN_B_PITCH
#endif
#ifdef TILE_OUT_B_PITCH
#undef TILE_OUT_B_PITCH
#endif
#ifdef BATCH_SIZE
#undef BATCH_SIZE
#endif

//====================================================
// Kernel template: fully_connected_gpu_bf_tiled 
// Kernel name: fully_connected_gpu_bf_tiled_4028700128260651592_0
#define KERNEL(name) __kernel void fully_connected_gpu_bf_tiled_4028700128260651592_0
#define FUNC(name)  _##name##_fully_connected_gpu_bf_tiled_4028700128260651592_0
#define FUNC_CALL(name)  _##name##_fully_connected_gpu_bf_tiled_4028700128260651592_0
#define CONST_ARRAY_DECL(name) __constant size_t  _##name##_fully_connected_gpu_bf_tiled_4028700128260651592_0 []
#define CONST_ARRAY_REF(name)  _##name##_fully_connected_gpu_bf_tiled_4028700128260651592_0
#define FP64_SUPPORTED 0
#define FP16_SUPPORTED 1
#define FP16_UNIT_USED 1
#define INT8_UNIT_USED 0
#define INT32_UNIT_USED 0
#define INT64_UNIT_USED 0
#define UINT8_UNIT_USED 0
#define UINT32_UNIT_USED 0
#define UNIT_TYPE half
#define UNIT_VAL_MAX HALF_MAX
#define UNIT_VAL_MIN -UNIT_VAL_MAX
#define UNIT_VAL_ONE 1.0h
#define UNIT_VAL_ZERO 0.0h
#define TO_UNIT_TYPE(v) convert_half(v)
#define TO_UNIT_TYPE_SAT(v) convert_half(v)
#define AS_UNIT_TYPE(v) as_half(v)
#define UNIT_MAX_FUNC fmax
#define UNIT_MIN_FUNC fmin
#define UNIT_ABS_FUNC fabs
#define UNIT_TYPE_SIZE 2
#define UNIT_IS_FP 1
#define NL_M_0 as_float(0x0)/*0.000000e+00*/
#define NL_N_0 as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_0_TYPE half
#define ACTIVATION_FUNC_0_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_0_VAL_MIN -ACTIVATION_FUNC_0_VAL_MAX
#define ACTIVATION_FUNC_0_VAL_ONE 1.0h
#define ACTIVATION_FUNC_0_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_0_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_0_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_0_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_0_MAX_FUNC fmax
#define ACTIVATION_FUNC_0_MIN_FUNC fmin
#define ACTIVATION_FUNC_0_ABS_FUNC fabs
#define ACTIVATION_FUNC_0_TYPE_SIZE 2
#define ACTIVATION_FUNC_0_IS_FP 1
#define ACTIVATION_PARAMS_0 NL_M_0, NL_N_0
#define ACTIVATION_FUNC_0(input, m, n) (ACTIVATION_FUNC_0_MAX_FUNC(ACTIVATION_FUNC_0_VAL_ZERO, input))
#define ACTIVATION_0(input, params) ACTIVATION_FUNC_0(input, params)
#define ACTIVATION_PARAMS ACTIVATION_PARAMS_0
#define ACTIVATION(input, params) ACTIVATION_FUNC_0(input, params)
#define INPUT0_SIZE_X 1
#define INPUT0_SIZE_Y 1
#define INPUT0_SIZE_Z 1
#define INPUT0_SIZE_W 1
#define INPUT0_SIZE_U 1
#define INPUT0_SIZE_V 1
#define INPUT0_FEATURE_NUM 64
#define INPUT0_BATCH_NUM 10
#define INPUT0_PAD_BEFORE_SIZE_X 0
#define INPUT0_PAD_BEFORE_SIZE_Y 0
#define INPUT0_PAD_BEFORE_SIZE_Z 0
#define INPUT0_PAD_BEFORE_SIZE_W 0
#define INPUT0_PAD_BEFORE_SIZE_U 0
#define INPUT0_PAD_BEFORE_SIZE_V 0
#define INPUT0_PAD_BEFORE_FEATURE_NUM 0
#define INPUT0_PAD_BEFORE_BATCH_NUM 0
#define INPUT0_PAD_AFTER_SIZE_X 0
#define INPUT0_PAD_AFTER_SIZE_Y 0
#define INPUT0_PAD_AFTER_SIZE_Z 0
#define INPUT0_PAD_AFTER_SIZE_W 0
#define INPUT0_PAD_AFTER_SIZE_U 0
#define INPUT0_PAD_AFTER_SIZE_V 0
#define INPUT0_PAD_AFTER_FEATURE_NUM 0
#define INPUT0_PAD_AFTER_BATCH_NUM 0
#define INPUT0_X_PITCH 1
#define INPUT0_Y_PITCH 1
#define INPUT0_Z_PITCH 1
#define INPUT0_W_PITCH 1
#define INPUT0_U_PITCH 1
#define INPUT0_V_PITCH 1
#define INPUT0_FEATURE_PITCH 1
#define INPUT0_BATCH_PITCH 64
#define INPUT0_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX(b, f, y, x) GET_DATA_INDEX(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(INPUT0, b, f, y, x)
#define INPUT0_VIEW_OFFSET 0
#define INPUT0_LENGTH 640
#define INPUT0_DIMS 4
#define INPUT0_SIMPLE 1
#define INPUT0_GROUPED 0
#define INPUT0_LAYOUT_BFYX 1
#define INPUT0_TYPE half
#define INPUT0_VAL_MAX HALF_MAX
#define INPUT0_VAL_MIN -INPUT0_VAL_MAX
#define INPUT0_VAL_ONE 1.0h
#define INPUT0_VAL_ZERO 0.0h
#define TO_INPUT0_TYPE(v) convert_half(v)
#define TO_INPUT0_TYPE_SAT(v) convert_half(v)
#define AS_INPUT0_TYPE(v) as_half(v)
#define INPUT0_MAX_FUNC fmax
#define INPUT0_MIN_FUNC fmin
#define INPUT0_ABS_FUNC fabs
#define INPUT0_TYPE_SIZE 2
#define INPUT0_IS_FP 1
#define INPUT0_OFFSET 0
#define INPUT0_SIZES_DATA { 1,1,64,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(INPUT0_SIZES) = INPUT0_SIZES_DATA;
#define INPUT0_SIZES CONST_ARRAY_REF(INPUT0_SIZES)
#define INPUT0_PITCHES (size_t []){ 1,1,1,64,1,1,1,1,1, } 
#define INPUT0_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define INPUT0_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_SIZE_X 1
#define OUTPUT_SIZE_Y 1
#define OUTPUT_SIZE_Z 1
#define OUTPUT_SIZE_W 1
#define OUTPUT_SIZE_U 1
#define OUTPUT_SIZE_V 1
#define OUTPUT_FEATURE_NUM 512
#define OUTPUT_BATCH_NUM 10
#define OUTPUT_PAD_BEFORE_SIZE_X 0
#define OUTPUT_PAD_BEFORE_SIZE_Y 0
#define OUTPUT_PAD_BEFORE_SIZE_Z 0
#define OUTPUT_PAD_BEFORE_SIZE_W 0
#define OUTPUT_PAD_BEFORE_SIZE_U 0
#define OUTPUT_PAD_BEFORE_SIZE_V 0
#define OUTPUT_PAD_BEFORE_FEATURE_NUM 0
#define OUTPUT_PAD_BEFORE_BATCH_NUM 0
#define OUTPUT_PAD_AFTER_SIZE_X 0
#define OUTPUT_PAD_AFTER_SIZE_Y 0
#define OUTPUT_PAD_AFTER_SIZE_Z 0
#define OUTPUT_PAD_AFTER_SIZE_W 0
#define OUTPUT_PAD_AFTER_SIZE_U 0
#define OUTPUT_PAD_AFTER_SIZE_V 0
#define OUTPUT_PAD_AFTER_FEATURE_NUM 0
#define OUTPUT_PAD_AFTER_BATCH_NUM 0
#define OUTPUT_X_PITCH 1
#define OUTPUT_Y_PITCH 1
#define OUTPUT_Z_PITCH 1
#define OUTPUT_W_PITCH 1
#define OUTPUT_U_PITCH 1
#define OUTPUT_V_PITCH 1
#define OUTPUT_FEATURE_PITCH 1
#define OUTPUT_BATCH_PITCH 512
#define OUTPUT_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX(b, f, y, x) GET_DATA_INDEX(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(OUTPUT, b, f, y, x)
#define OUTPUT_VIEW_OFFSET 0
#define OUTPUT_LENGTH 5120
#define OUTPUT_DIMS 2
#define OUTPUT_SIMPLE 1
#define OUTPUT_GROUPED 0
#define OUTPUT_LAYOUT_BF 1
#define OUTPUT_TYPE half
#define OUTPUT_VAL_MAX HALF_MAX
#define OUTPUT_VAL_MIN -OUTPUT_VAL_MAX
#define OUTPUT_VAL_ONE 1.0h
#define OUTPUT_VAL_ZERO 0.0h
#define TO_OUTPUT_TYPE(v) convert_half(v)
#define TO_OUTPUT_TYPE_SAT(v) convert_half(v)
#define AS_OUTPUT_TYPE(v) as_half(v)
#define OUTPUT_MAX_FUNC fmax
#define OUTPUT_MIN_FUNC fmin
#define OUTPUT_ABS_FUNC fabs
#define OUTPUT_TYPE_SIZE 2
#define OUTPUT_IS_FP 1
#define OUTPUT_OFFSET 0
#define OUTPUT_SIZES_DATA { 512,10,1,1,1,1,1,1,1, } 
CONST_ARRAY_DECL(OUTPUT_SIZES) = OUTPUT_SIZES_DATA;
#define OUTPUT_SIZES CONST_ARRAY_REF(OUTPUT_SIZES)
#define OUTPUT_PITCHES (size_t []){ 1,512,1,1,1,1,1,1,1, } 
#define OUTPUT_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OPTIONAL_SHAPE_INFO_ARG 
#define OPTIONAL_SHAPE_INFO_TENSOR 
#define FILTER_SIZE_X 1
#define FILTER_SIZE_Y 1
#define FILTER_SIZE_Z 1
#define FILTER_IFM_NUM 64
#define FILTER_OFM_NUM 512
#define FILTER_GROUPS_NUM 1
#define FILTER_X_PITCH 1
#define FILTER_Y_PITCH 1
#define FILTER_Z_PITCH 1
#define FILTER_IFM_PITCH 1
#define FILTER_OFM_PITCH 64
#define FILTER_GROUPS_PITCH 1
#define FILTER_VIEW_OFFSET 0
#define FILTER_LENGTH 32768
#define FILTER_DIMS 4
#define FILTER_SIMPLE 0
#define FILTER_GROUPED 0
#define FILTER_LAYOUT_OS_IYX_OSV32 1
#define FILTER_TYPE half
#define FILTER_VAL_MAX HALF_MAX
#define FILTER_VAL_MIN -FILTER_VAL_MAX
#define FILTER_VAL_ONE 1.0h
#define FILTER_VAL_ZERO 0.0h
#define TO_FILTER_TYPE(v) convert_half(v)
#define TO_FILTER_TYPE_SAT(v) convert_half(v)
#define AS_FILTER_TYPE(v) as_half(v)
#define FILTER_MAX_FUNC fmax
#define FILTER_MIN_FUNC fmin
#define FILTER_ABS_FUNC fabs
#define FILTER_TYPE_SIZE 2
#define FILTER_IS_FP 1
#define FILTER_OFFSET 0
#define FILTER_SIZES_DATA { 1,1,64,512,1,1,1,1,1, } 
CONST_ARRAY_DECL(FILTER_SIZES) = FILTER_SIZES_DATA;
#define FILTER_SIZES CONST_ARRAY_REF(FILTER_SIZES)
#define FILTER_PITCHES (size_t []){ 1,1,1,64,1,1,1,1,1, } 
#define FILTER_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define FILTER_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_TERM 1
#define BIAS_SIZE_X 1
#define BIAS_SIZE_Y 1
#define BIAS_SIZE_Z 1
#define BIAS_SIZE_W 1
#define BIAS_SIZE_U 1
#define BIAS_SIZE_V 1
#define BIAS_FEATURE_NUM 512
#define BIAS_BATCH_NUM 1
#define BIAS_PAD_BEFORE_SIZE_X 0
#define BIAS_PAD_BEFORE_SIZE_Y 0
#define BIAS_PAD_BEFORE_SIZE_Z 0
#define BIAS_PAD_BEFORE_SIZE_W 0
#define BIAS_PAD_BEFORE_SIZE_U 0
#define BIAS_PAD_BEFORE_SIZE_V 0
#define BIAS_PAD_BEFORE_FEATURE_NUM 0
#define BIAS_PAD_BEFORE_BATCH_NUM 0
#define BIAS_PAD_AFTER_SIZE_X 0
#define BIAS_PAD_AFTER_SIZE_Y 0
#define BIAS_PAD_AFTER_SIZE_Z 0
#define BIAS_PAD_AFTER_SIZE_W 0
#define BIAS_PAD_AFTER_SIZE_U 0
#define BIAS_PAD_AFTER_SIZE_V 0
#define BIAS_PAD_AFTER_FEATURE_NUM 0
#define BIAS_PAD_AFTER_BATCH_NUM 0
#define BIAS_X_PITCH 1
#define BIAS_Y_PITCH 1
#define BIAS_Z_PITCH 1
#define BIAS_W_PITCH 1
#define BIAS_U_PITCH 1
#define BIAS_V_PITCH 1
#define BIAS_FEATURE_PITCH 1
#define BIAS_BATCH_PITCH 512
#define BIAS_GET_INDEX_SAFE(b, f, y, x) ((0 + (f)) % 512)
#define BIAS_GET_INDEX(b, f, y, x) (0 + (f))
#define BIAS_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(BIAS, b, f, y, x)
#define BIAS_VIEW_OFFSET 0
#define BIAS_LENGTH 512
#define BIAS_DIMS 2
#define BIAS_SIMPLE 1
#define BIAS_GROUPED 0
#define BIAS_LAYOUT_BF 1
#define BIAS_TYPE half
#define BIAS_VAL_MAX HALF_MAX
#define BIAS_VAL_MIN -BIAS_VAL_MAX
#define BIAS_VAL_ONE 1.0h
#define BIAS_VAL_ZERO 0.0h
#define TO_BIAS_TYPE(v) convert_half(v)
#define TO_BIAS_TYPE_SAT(v) convert_half(v)
#define AS_BIAS_TYPE(v) as_half(v)
#define BIAS_MAX_FUNC fmax
#define BIAS_MIN_FUNC fmin
#define BIAS_ABS_FUNC fabs
#define BIAS_TYPE_SIZE 2
#define BIAS_IS_FP 1
#define BIAS_OFFSET 0
#define BIAS_SIZES_DATA { 512,1,1,1,1,1,1,1,1, } 
CONST_ARRAY_DECL(BIAS_SIZES) = BIAS_SIZES_DATA;
#define BIAS_SIZES CONST_ARRAY_REF(BIAS_SIZES)
#define BIAS_PITCHES (size_t []){ 1,512,1,1,1,1,1,1,1, } 
#define BIAS_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define BIAS_PER_OUTPUT 0
#define BIAS_PER_OFM 1
#define INPUT0_ELEMENTS_COUNT 64
#define SIMD 16
#define TILE_B 5
#define TILE_OFM 2
#define TILE_IFM 1
#define TILE_K 2
#define TILE_K_OFM 4
#define DISPATCH_BSV 2
#define DISPATCH_FSV 1
#define CONST_LOOP_CALL(macro, idx) macro(idx)
#define CONST_LOOP_1(macro) CONST_LOOP_CALL(macro, 0)
#define CONST_LOOP_2(macro) CONST_LOOP_1(macro); CONST_LOOP_CALL(macro,1)
#define CONST_LOOP_3(macro) CONST_LOOP_2(macro); CONST_LOOP_CALL(macro,2)
#define CONST_LOOP_4(macro) CONST_LOOP_3(macro); CONST_LOOP_CALL(macro,3)
#define CONST_LOOP_5(macro) CONST_LOOP_4(macro); CONST_LOOP_CALL(macro,4)
#define CONST_LOOP(count, macro) CAT(CONST_LOOP_, count)(macro)
#define REALIGN_FP16_OFFSET 0
#define ACTIVATION_TYPE half
#define ACTIVATION_VAL_MAX HALF_MAX
#define ACTIVATION_VAL_MIN -ACTIVATION_VAL_MAX
#define ACTIVATION_VAL_ONE 1.0h
#define ACTIVATION_VAL_ZERO 0.0h
#define TO_ACTIVATION_TYPE(v) convert_half(v)
#define TO_ACTIVATION_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_TYPE(v) as_half(v)
#define ACTIVATION_MAX_FUNC fmax
#define ACTIVATION_MIN_FUNC fmin
#define ACTIVATION_ABS_FUNC fabs
#define ACTIVATION_TYPE_SIZE 2
#define ACTIVATION_IS_FP 1
#define NL_M_TYPED_0 as_float(0x0)/*0.000000e+00*/
#define NL_N_TYPED_0 as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPED_0_TYPE half
#define ACTIVATION_FUNC_TYPED_0_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_TYPED_0_VAL_MIN -ACTIVATION_FUNC_TYPED_0_VAL_MAX
#define ACTIVATION_FUNC_TYPED_0_VAL_ONE 1.0h
#define ACTIVATION_FUNC_TYPED_0_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPED_0_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPED_0_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPED_0_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_TYPED_0_MAX_FUNC fmax
#define ACTIVATION_FUNC_TYPED_0_MIN_FUNC fmin
#define ACTIVATION_FUNC_TYPED_0_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPED_0_TYPE_SIZE 2
#define ACTIVATION_FUNC_TYPED_0_IS_FP 1
#define ACTIVATION_PARAMS_TYPED_0 NL_M_TYPED_0, NL_N_TYPED_0
#define ACTIVATION_FUNC_TYPED_0(input, m, n) (ACTIVATION_FUNC_TYPED_0_MAX_FUNC(ACTIVATION_FUNC_TYPED_0_VAL_ZERO, input))
#define ACTIVATION_TYPED_0(input, params) ACTIVATION_FUNC_TYPED_0(input, params)
#define ACTIVATION_PARAMS_TYPED ACTIVATION_PARAMS_TYPED_0
#define ACTIVATION_TYPED(input, params) ACTIVATION_FUNC_TYPED_0(input, params)
#define ACCUMULATOR_TYPE half
#define ACCUMULATOR_VAL_MAX HALF_MAX
#define ACCUMULATOR_VAL_MIN -ACCUMULATOR_VAL_MAX
#define ACCUMULATOR_VAL_ONE 1.0h
#define ACCUMULATOR_VAL_ZERO 0.0h
#define TO_ACCUMULATOR_TYPE(v) convert_half(v)
#define TO_ACCUMULATOR_TYPE_SAT(v) convert_half(v)
#define AS_ACCUMULATOR_TYPE(v) as_half(v)
#define ACCUMULATOR_MAX_FUNC fmax
#define ACCUMULATOR_MIN_FUNC fmin
#define ACCUMULATOR_ABS_FUNC fabs
#define ACCUMULATOR_TYPE_SIZE 2
#define ACCUMULATOR_IS_FP 1
#define TILE_OUT_F_NUM 512
#define TILE_OUT_F_PITCH 1
#define TILE_IN_B_PITCH 64
#define TILE_OUT_B_PITCH 512
#define BATCH_SIZE (OUTPUT_BATCH_NUM)


#if SIMD != 8 && SIMD != 16
# error "fully_connected_gpu_bf_tiled.cl - SIMD must be one of {8, 16}"
#endif
#if TILE_OFM != 1 && TILE_OFM != 2 && TILE_OFM != 4 && TILE_OFM != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_OFM must be one of {1, 2, 4, 8}"
#endif
#if TILE_IFM != 1 && TILE_IFM != 2 && TILE_IFM != 4 && TILE_IFM != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_IFM must be one of {1, 2, 4, 8}"
#endif
#if TILE_K != 1 && TILE_K != 2 && TILE_K != 4 && TILE_K != 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_K must be one of {1, 2, 4, 8}"
#endif
#if TILE_K_OFM != (TILE_K * TILE_OFM) || TILE_K_OFM > 8
# error "fully_connected_gpu_bf_tiled.cl - TILE_K_OFM must be equal to TILE_K * TILE_OFM and at most 8"
#endif
#define INPUT_VEC_TYPE MAKE_VECTOR_TYPE(INPUT0_TYPE, TILE_IFM)
#define ACCUMULATOR_VEC_TYPE MAKE_VECTOR_TYPE(ACCUMULATOR_TYPE, TILE_OFM)
#define FILTER_VEC_TYPE MAKE_VECTOR_TYPE(FILTER_TYPE, TILE_K_OFM)
#define BIAS_VEC_TYPE MAKE_VECTOR_TYPE(BIAS_TYPE, TILE_OFM)
#define OUTPUT_VEC_TYPE MAKE_VECTOR_TYPE(OUTPUT_TYPE, TILE_OFM)
#define ACTIVATION_VEC_TYPE MAKE_VECTOR_TYPE(ACTIVATION_TYPE, TILE_OFM)
#define TO_OUTPUT_VEC_TYPE(x) CAT(convert_, OUTPUT_VEC_TYPE)(x)
#define TO_ACTIVATION_VEC_TYPE(x) CAT(convert_, ACTIVATION_VEC_TYPE)(x)
#define INPUT_BLOCK_READ(ptr, offset) BLOCK_READN(INPUT0_TYPE, TILE_IFM, ptr, offset)
#define FILTER_BLOCK_READ(ptr, offset) BLOCK_READN(FILTER_TYPE, TILE_K_OFM, ptr, offset)
#define BIAS_BLOCK_READ(ptr, offset) BLOCK_READN(BIAS_TYPE, TILE_OFM, ptr, offset)
#define OUTPUT_BLOCK_WRITE(ptr, offset, val) BLOCK_WRITEN(OUTPUT_TYPE, TILE_OFM, ptr, offset, val)
#define USE_BLOCK_WRITE ((OUTPUT_TYPE_SIZE * TILE_OUT_B_PITCH) % 16 == 0 && (OUTPUT_TYPE_SIZE * OUTPUT_OFFSET) % 16 == 0)
#if !REALIGN_FP16_OFFSET
# if OUTPUT_3D
# define MAIN_LOOP_ELEMENTS_COUNT INPUT0_SIZE_Y
# else
# define MAIN_LOOP_ELEMENTS_COUNT INPUT0_ELEMENTS_COUNT
# endif
#else
# if OUTPUT_3D
# define MAIN_LOOP_ELEMENTS_COUNT (INPUT0_SIZE_Y - 1)
# else
# define MAIN_LOOP_ELEMENTS_COUNT (INPUT0_ELEMENTS_COUNT - 1)
# endif
#endif
#if OUTPUT_3D
# define INPUT_ELEMENTS_COUNT INPUT0_SIZE_Y
#else
# define INPUT_ELEMENTS_COUNT INPUT0_ELEMENTS_COUNT
#endif
REQD_SUB_GROUP_SIZE(SIMD)
KERNEL(fc)(
 OPTIONAL_SHAPE_INFO_ARG
 const __global INPUT0_TYPE* input,
 __global OUTPUT_TYPE* output,
 const __global FILTER_TYPE* weights
#if BIAS_TERM
 , const __global BIAS_TYPE* biases
#endif
#if HAS_FUSED_OPS_DECLS
 , FUSED_OPS_DECLS
#endif
) {
 uint gid = (uint)get_group_id(0);
 uint sglid = (uint)get_sub_group_local_id();
 uint feature_mini_block = gid % DISPATCH_FSV;
 uint batch_mini_block = gid / DISPATCH_FSV % DISPATCH_BSV;
 uint feature_mega_block = gid / (DISPATCH_FSV * DISPATCH_BSV) % (CEIL_DIV(TILE_OUT_F_NUM, TILE_OFM * SIMD) / DISPATCH_FSV);
 uint batch_mega_block = gid / (DISPATCH_FSV * DISPATCH_BSV * CEIL_DIV(TILE_OUT_F_NUM, TILE_OFM * SIMD) / DISPATCH_FSV);
 uint out_f = (feature_mega_block * DISPATCH_FSV + feature_mini_block) * (TILE_OFM * SIMD);
 uint out_b = ((batch_mega_block * DISPATCH_BSV + batch_mini_block) * TILE_B);
 ACCUMULATOR_VEC_TYPE acc[TILE_B] = { };
 INPUT_VEC_TYPE in_0[TILE_B] = { };
 FILTER_VEC_TYPE wei = 0;
 uint input_offset = out_b * TILE_IN_B_PITCH + INPUT0_OFFSET;
 uint weights_offset = out_f * INPUT_ELEMENTS_COUNT;
#if REALIGN_FP16_OFFSET
 {
 INPUT0_TYPE tmp_input = input[input_offset + get_sub_group_local_id() % TILE_B * TILE_IN_B_PITCH];
 MAKE_VECTOR_TYPE(FILTER_TYPE, TILE_OFM) tmp_wei = BLOCK_READN(FILTER_TYPE, TILE_OFM, weights, weights_offset);
 unroll_for(uint bi = 0; bi < TILE_B; ++bi) {
 acc[bi] = _sub_group_shuffle(tmp_input, bi) * tmp_wei;
 }
 weights_offset += TILE_OFM * SIMD;
 input_offset += 1;
 }
#endif
 uint iterations = MAIN_LOOP_ELEMENTS_COUNT / (TILE_IFM * SIMD);
 __attribute__((opencl_unroll_hint(1)))
 for (uint ni = 0; ni < iterations; ++ni) {
 #define LOAD_IN_0(bi) do { in_0[bi] = INPUT_BLOCK_READ(input, input_offset); input_offset += TILE_IN_B_PITCH; } while (false)
 CONST_LOOP(TILE_B, LOAD_IN_0);
 #undef LOAD_IN_0
 input_offset += TILE_IFM * SIMD - TILE_IN_B_PITCH * TILE_B;
 unroll_for(uint ki = 0; ki < (TILE_IFM * SIMD) / TILE_K; ++ki) {
 wei = FILTER_BLOCK_READ(weights, weights_offset);
 weights_offset += TILE_K_OFM * SIMD;
 unroll_for (uint kii = 0; kii < TILE_K; ++kii) {
 const uint total_k = ki * TILE_K + kii;
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 INPUT0_TYPE in_val = _sub_group_shuffle(((INPUT0_TYPE*)(&in_0[bi]))[total_k / SIMD], total_k % SIMD);
 unroll_for (uint fi = 0; fi < TILE_OFM; ++fi) {
 ((ACCUMULATOR_TYPE*)(&acc[bi]))[fi] += in_val * ((FILTER_TYPE*)(&wei))[kii * TILE_OFM + fi];
 }
 }
 }
 }
 }
#if MAIN_LOOP_ELEMENTS_COUNT % (TILE_IFM * SIMD) != 0
 #define LEFTOVER_IFM (MAIN_LOOP_ELEMENTS_COUNT % (TILE_IFM * SIMD))
 {
 #define LOAD_IN_0(bi) do { in_0[bi] = INPUT_BLOCK_READ(input, input_offset); input_offset += TILE_IN_B_PITCH; } while (false)
 CONST_LOOP(TILE_B, LOAD_IN_0);
 #undef LOAD_IN_0
 input_offset += TILE_IFM * SIMD - TILE_IN_B_PITCH * TILE_B;
 unroll_for(uint ki = 0; ki < CEIL_DIV(LEFTOVER_IFM, TILE_K); ++ki) {
 wei = FILTER_BLOCK_READ(weights, weights_offset);
 weights_offset += TILE_K_OFM * SIMD;
 unroll_for (uint kii = 0; kii < TILE_K; ++kii) {
 unroll_for (uint fi = 0; fi < TILE_OFM; ++fi) {
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 const uint total_k = ki * TILE_K + kii;
 if (total_k < LEFTOVER_IFM) {
 INPUT0_TYPE in_val = _sub_group_shuffle(((INPUT0_TYPE*)(&in_0[bi]))[total_k / SIMD], total_k % SIMD);
 ((ACCUMULATOR_TYPE*)(&acc[bi]))[fi] += in_val * ((FILTER_TYPE*)(&wei))[kii * TILE_OFM + fi];
 }
 }
 }
 }
 }
 }
 #undef LEFTOVER_IFM
#endif
 ACTIVATION_VEC_TYPE activated[TILE_B] = { };
 for (uint bi = 0; bi < TILE_B; ++bi) {
 activated[bi] = TO_ACTIVATION_VEC_TYPE(acc[bi]);
 }
#if BIAS_TERM
 #if TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0
 BIAS_VEC_TYPE bias = BIAS_BLOCK_READ(biases, out_f);
 #else
 BIAS_VEC_TYPE bias = 0;
 unroll_for(uint fi = 0; fi < TILE_OFM; ++fi) {
 ((BIAS_TYPE*)(&bias))[fi] = biases[out_f + sglid + fi * SIMD];
 }
 #endif
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 activated[bi] += TO_ACTIVATION_VEC_TYPE(bias);
 }
#endif
 OUTPUT_VEC_TYPE result[TILE_B] = { };
#if HAS_FUSED_OPS
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 #if TILE_OFM > 1
 unroll_for(uint fi = 0; fi < TILE_OFM; ++fi) {
 FUSED_OPS_VEC;
 result[bi][fi] = FUSED_OPS_RESULT_VEC;
 }
 #else
 FUSED_OPS_SCALAR;
 result[bi] = FUSED_OPS_RESULT_SCALAR;
 #endif
 }
#else
 unroll_for (uint bi = 0; bi < TILE_B; ++bi) {
 result[bi] = TO_OUTPUT_VEC_TYPE(ACTIVATION_TYPED(activated[bi], ACTIVATION_PARAMS_TYPED));
 }
#endif
 uint output_offset = out_f * TILE_OUT_F_PITCH + out_b * TILE_OUT_B_PITCH + OUTPUT_OFFSET;
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
#if IS_DYNAMIC
 #define WRITE_OUTPUT(bi) do { if (bi + out_b < BATCH_SIZE) OUTPUT_BLOCK_WRITE(output, output_offset, result[bi]); output_offset += TILE_OUT_B_PITCH; } while (false)
#else
 #define WRITE_OUTPUT(bi) do { OUTPUT_BLOCK_WRITE(output, output_offset, result[bi]); output_offset += TILE_OUT_B_PITCH; } while (false)
#endif
 CONST_LOOP(TILE_B, WRITE_OUTPUT);
 #undef WRITE_OUTPUT
 } else {
 output_offset += sglid;
 for (uint bi = 0; bi < TILE_B; ++bi) {
 for (uint fi = 0; fi < TILE_OFM; ++fi) {
 const bool should_write =
#if IS_DYNAMIC
 bi + out_b < BATCH_SIZE &&
#endif
 (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 ||
 out_f + fi * SIMD + sglid < TILE_OUT_F_NUM);
 if (should_write) {
 output[output_offset] = ((OUTPUT_TYPE*)(&result[bi]))[fi];
 }
 output_offset += SIMD;
 }
 output_offset += TILE_OUT_B_PITCH - TILE_OFM * SIMD;
 }
 }
}
#undef INPUT_VEC_TYPE
#undef ACCUMULATOR_VEC_TYPE
#undef FILTER_VEC_TYPE
#undef BIAS_VEC_TYPE
#undef OUTPUT_VEC_TYPE
#undef ACTIVATION_VEC_TYPE
#undef TO_OUTPUT_VEC_TYPE
#undef TO_ACTIVATION_VEC_TYPE
#undef INPUT_BLOCK_READ
#undef FILTER_BLOCK_READ
#undef BIAS_BLOCK_READ
#undef OUTPUT_BLOCK_WRITE
#undef USE_BLOCK_WRITE
#undef MAIN_LOOP_ELEMENTS_COUNT
#ifdef INPUT_VEC_TYPE
#undef INPUT_VEC_TYPE
#endif
#ifdef ACCUMULATOR_VEC_TYPE
#undef ACCUMULATOR_VEC_TYPE
#endif
#ifdef FILTER_VEC_TYPE
#undef FILTER_VEC_TYPE
#endif
#ifdef BIAS_VEC_TYPE
#undef BIAS_VEC_TYPE
#endif
#ifdef OUTPUT_VEC_TYPE
#undef OUTPUT_VEC_TYPE
#endif
#ifdef ACTIVATION_VEC_TYPE
#undef ACTIVATION_VEC_TYPE
#endif
#ifdef TO_OUTPUT_VEC_TYPE
#undef TO_OUTPUT_VEC_TYPE
#endif
#ifdef TO_ACTIVATION_VEC_TYPE
#undef TO_ACTIVATION_VEC_TYPE
#endif
#ifdef INPUT_BLOCK_READ
#undef INPUT_BLOCK_READ
#endif
#ifdef FILTER_BLOCK_READ
#undef FILTER_BLOCK_READ
#endif
#ifdef BIAS_BLOCK_READ
#undef BIAS_BLOCK_READ
#endif
#ifdef OUTPUT_BLOCK_WRITE
#undef OUTPUT_BLOCK_WRITE
#endif
#ifdef USE_BLOCK_WRITE
#undef USE_BLOCK_WRITE
#endif
#ifdef LOAD_IN_0
#undef LOAD_IN_0
#endif
#ifdef LEFTOVER_IFM
#undef LEFTOVER_IFM
#endif
#ifdef LOAD_IN_0
#undef LOAD_IN_0
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#ifdef WRITE_OUTPUT_FEATURE
#undef WRITE_OUTPUT_FEATURE
#endif
#ifdef WRITE_OUTPUT
#undef WRITE_OUTPUT
#endif
#undef KERNEL
#undef FUNC
#undef FUNC_CALL
#undef CONST_ARRAY_DECL
#undef CONST_ARRAY_REF
#ifdef FP64_SUPPORTED
#undef FP64_SUPPORTED
#endif
#ifdef FP16_SUPPORTED
#undef FP16_SUPPORTED
#endif
#ifdef FP16_UNIT_USED
#undef FP16_UNIT_USED
#endif
#ifdef INT8_UNIT_USED
#undef INT8_UNIT_USED
#endif
#ifdef INT32_UNIT_USED
#undef INT32_UNIT_USED
#endif
#ifdef INT64_UNIT_USED
#undef INT64_UNIT_USED
#endif
#ifdef UINT8_UNIT_USED
#undef UINT8_UNIT_USED
#endif
#ifdef UINT32_UNIT_USED
#undef UINT32_UNIT_USED
#endif
#ifdef UNIT_TYPE
#undef UNIT_TYPE
#endif
#ifdef UNIT_VAL_MAX
#undef UNIT_VAL_MAX
#endif
#ifdef UNIT_VAL_MIN
#undef UNIT_VAL_MIN
#endif
#ifdef UNIT_VAL_ONE
#undef UNIT_VAL_ONE
#endif
#ifdef UNIT_VAL_ZERO
#undef UNIT_VAL_ZERO
#endif
#ifdef TO_UNIT_TYPE
#undef TO_UNIT_TYPE
#endif
#ifdef TO_UNIT_TYPE_SAT
#undef TO_UNIT_TYPE_SAT
#endif
#ifdef AS_UNIT_TYPE
#undef AS_UNIT_TYPE
#endif
#ifdef UNIT_MAX_FUNC
#undef UNIT_MAX_FUNC
#endif
#ifdef UNIT_MIN_FUNC
#undef UNIT_MIN_FUNC
#endif
#ifdef UNIT_ABS_FUNC
#undef UNIT_ABS_FUNC
#endif
#ifdef UNIT_TYPE_SIZE
#undef UNIT_TYPE_SIZE
#endif
#ifdef UNIT_IS_FP
#undef UNIT_IS_FP
#endif
#ifdef NL_M_0
#undef NL_M_0
#endif
#ifdef NL_N_0
#undef NL_N_0
#endif
#ifdef ACTIVATION_FUNC_0_TYPE
#undef ACTIVATION_FUNC_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_0_VAL_MAX
#undef ACTIVATION_FUNC_0_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_0_VAL_MIN
#undef ACTIVATION_FUNC_0_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_0_VAL_ONE
#undef ACTIVATION_FUNC_0_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_0_VAL_ZERO
#undef ACTIVATION_FUNC_0_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_0_TYPE
#undef TO_ACTIVATION_FUNC_0_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_0_TYPE_SAT
#undef TO_ACTIVATION_FUNC_0_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_0_TYPE
#undef AS_ACTIVATION_FUNC_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_0_MAX_FUNC
#undef ACTIVATION_FUNC_0_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_0_MIN_FUNC
#undef ACTIVATION_FUNC_0_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_0_ABS_FUNC
#undef ACTIVATION_FUNC_0_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_0_TYPE_SIZE
#undef ACTIVATION_FUNC_0_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_0_IS_FP
#undef ACTIVATION_FUNC_0_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_0
#undef ACTIVATION_PARAMS_0
#endif
#ifdef ACTIVATION_FUNC_0
#undef ACTIVATION_FUNC_0
#endif
#ifdef ACTIVATION_0
#undef ACTIVATION_0
#endif
#ifdef ACTIVATION_PARAMS
#undef ACTIVATION_PARAMS
#endif
#ifdef ACTIVATION
#undef ACTIVATION
#endif
#ifdef INPUT0_SIZE_X
#undef INPUT0_SIZE_X
#endif
#ifdef INPUT0_SIZE_Y
#undef INPUT0_SIZE_Y
#endif
#ifdef INPUT0_SIZE_Z
#undef INPUT0_SIZE_Z
#endif
#ifdef INPUT0_SIZE_W
#undef INPUT0_SIZE_W
#endif
#ifdef INPUT0_SIZE_U
#undef INPUT0_SIZE_U
#endif
#ifdef INPUT0_SIZE_V
#undef INPUT0_SIZE_V
#endif
#ifdef INPUT0_FEATURE_NUM
#undef INPUT0_FEATURE_NUM
#endif
#ifdef INPUT0_BATCH_NUM
#undef INPUT0_BATCH_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_X
#undef INPUT0_PAD_BEFORE_SIZE_X
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Y
#undef INPUT0_PAD_BEFORE_SIZE_Y
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Z
#undef INPUT0_PAD_BEFORE_SIZE_Z
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_W
#undef INPUT0_PAD_BEFORE_SIZE_W
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_U
#undef INPUT0_PAD_BEFORE_SIZE_U
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_V
#undef INPUT0_PAD_BEFORE_SIZE_V
#endif
#ifdef INPUT0_PAD_BEFORE_FEATURE_NUM
#undef INPUT0_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_BATCH_NUM
#undef INPUT0_PAD_BEFORE_BATCH_NUM
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_X
#undef INPUT0_PAD_AFTER_SIZE_X
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Y
#undef INPUT0_PAD_AFTER_SIZE_Y
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Z
#undef INPUT0_PAD_AFTER_SIZE_Z
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_W
#undef INPUT0_PAD_AFTER_SIZE_W
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_U
#undef INPUT0_PAD_AFTER_SIZE_U
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_V
#undef INPUT0_PAD_AFTER_SIZE_V
#endif
#ifdef INPUT0_PAD_AFTER_FEATURE_NUM
#undef INPUT0_PAD_AFTER_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_AFTER_BATCH_NUM
#undef INPUT0_PAD_AFTER_BATCH_NUM
#endif
#ifdef INPUT0_X_PITCH
#undef INPUT0_X_PITCH
#endif
#ifdef INPUT0_Y_PITCH
#undef INPUT0_Y_PITCH
#endif
#ifdef INPUT0_Z_PITCH
#undef INPUT0_Z_PITCH
#endif
#ifdef INPUT0_W_PITCH
#undef INPUT0_W_PITCH
#endif
#ifdef INPUT0_U_PITCH
#undef INPUT0_U_PITCH
#endif
#ifdef INPUT0_V_PITCH
#undef INPUT0_V_PITCH
#endif
#ifdef INPUT0_FEATURE_PITCH
#undef INPUT0_FEATURE_PITCH
#endif
#ifdef INPUT0_BATCH_PITCH
#undef INPUT0_BATCH_PITCH
#endif
#ifdef INPUT0_GET_INDEX_SAFE
#undef INPUT0_GET_INDEX_SAFE
#endif
#ifdef INPUT0_GET_INDEX
#undef INPUT0_GET_INDEX
#endif
#ifdef INPUT0_GET_INDEX_RAW
#undef INPUT0_GET_INDEX_RAW
#endif
#ifdef INPUT0_VIEW_OFFSET
#undef INPUT0_VIEW_OFFSET
#endif
#ifdef INPUT0_LENGTH
#undef INPUT0_LENGTH
#endif
#ifdef INPUT0_DIMS
#undef INPUT0_DIMS
#endif
#ifdef INPUT0_SIMPLE
#undef INPUT0_SIMPLE
#endif
#ifdef INPUT0_GROUPED
#undef INPUT0_GROUPED
#endif
#ifdef INPUT0_LAYOUT_BFYX
#undef INPUT0_LAYOUT_BFYX
#endif
#ifdef INPUT0_TYPE
#undef INPUT0_TYPE
#endif
#ifdef INPUT0_VAL_MAX
#undef INPUT0_VAL_MAX
#endif
#ifdef INPUT0_VAL_MIN
#undef INPUT0_VAL_MIN
#endif
#ifdef INPUT0_VAL_ONE
#undef INPUT0_VAL_ONE
#endif
#ifdef INPUT0_VAL_ZERO
#undef INPUT0_VAL_ZERO
#endif
#ifdef TO_INPUT0_TYPE
#undef TO_INPUT0_TYPE
#endif
#ifdef TO_INPUT0_TYPE_SAT
#undef TO_INPUT0_TYPE_SAT
#endif
#ifdef AS_INPUT0_TYPE
#undef AS_INPUT0_TYPE
#endif
#ifdef INPUT0_MAX_FUNC
#undef INPUT0_MAX_FUNC
#endif
#ifdef INPUT0_MIN_FUNC
#undef INPUT0_MIN_FUNC
#endif
#ifdef INPUT0_ABS_FUNC
#undef INPUT0_ABS_FUNC
#endif
#ifdef INPUT0_TYPE_SIZE
#undef INPUT0_TYPE_SIZE
#endif
#ifdef INPUT0_IS_FP
#undef INPUT0_IS_FP
#endif
#ifdef INPUT0_OFFSET
#undef INPUT0_OFFSET
#endif
#ifdef INPUT0_SIZES_DATA
#undef INPUT0_SIZES_DATA
#endif
#ifdef INPUT0_PITCHES
#undef INPUT0_PITCHES
#endif
#ifdef INPUT0_PAD_BEFORE
#undef INPUT0_PAD_BEFORE
#endif
#ifdef INPUT0_PAD_AFTER
#undef INPUT0_PAD_AFTER
#endif
#ifdef OUTPUT_SIZE_X
#undef OUTPUT_SIZE_X
#endif
#ifdef OUTPUT_SIZE_Y
#undef OUTPUT_SIZE_Y
#endif
#ifdef OUTPUT_SIZE_Z
#undef OUTPUT_SIZE_Z
#endif
#ifdef OUTPUT_SIZE_W
#undef OUTPUT_SIZE_W
#endif
#ifdef OUTPUT_SIZE_U
#undef OUTPUT_SIZE_U
#endif
#ifdef OUTPUT_SIZE_V
#undef OUTPUT_SIZE_V
#endif
#ifdef OUTPUT_FEATURE_NUM
#undef OUTPUT_FEATURE_NUM
#endif
#ifdef OUTPUT_BATCH_NUM
#undef OUTPUT_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_X
#undef OUTPUT_PAD_BEFORE_SIZE_X
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Y
#undef OUTPUT_PAD_BEFORE_SIZE_Y
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Z
#undef OUTPUT_PAD_BEFORE_SIZE_Z
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_W
#undef OUTPUT_PAD_BEFORE_SIZE_W
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_U
#undef OUTPUT_PAD_BEFORE_SIZE_U
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_V
#undef OUTPUT_PAD_BEFORE_SIZE_V
#endif
#ifdef OUTPUT_PAD_BEFORE_FEATURE_NUM
#undef OUTPUT_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_BATCH_NUM
#undef OUTPUT_PAD_BEFORE_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_X
#undef OUTPUT_PAD_AFTER_SIZE_X
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Y
#undef OUTPUT_PAD_AFTER_SIZE_Y
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Z
#undef OUTPUT_PAD_AFTER_SIZE_Z
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_W
#undef OUTPUT_PAD_AFTER_SIZE_W
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_U
#undef OUTPUT_PAD_AFTER_SIZE_U
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_V
#undef OUTPUT_PAD_AFTER_SIZE_V
#endif
#ifdef OUTPUT_PAD_AFTER_FEATURE_NUM
#undef OUTPUT_PAD_AFTER_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_BATCH_NUM
#undef OUTPUT_PAD_AFTER_BATCH_NUM
#endif
#ifdef OUTPUT_X_PITCH
#undef OUTPUT_X_PITCH
#endif
#ifdef OUTPUT_Y_PITCH
#undef OUTPUT_Y_PITCH
#endif
#ifdef OUTPUT_Z_PITCH
#undef OUTPUT_Z_PITCH
#endif
#ifdef OUTPUT_W_PITCH
#undef OUTPUT_W_PITCH
#endif
#ifdef OUTPUT_U_PITCH
#undef OUTPUT_U_PITCH
#endif
#ifdef OUTPUT_V_PITCH
#undef OUTPUT_V_PITCH
#endif
#ifdef OUTPUT_FEATURE_PITCH
#undef OUTPUT_FEATURE_PITCH
#endif
#ifdef OUTPUT_BATCH_PITCH
#undef OUTPUT_BATCH_PITCH
#endif
#ifdef OUTPUT_GET_INDEX_SAFE
#undef OUTPUT_GET_INDEX_SAFE
#endif
#ifdef OUTPUT_GET_INDEX
#undef OUTPUT_GET_INDEX
#endif
#ifdef OUTPUT_GET_INDEX_RAW
#undef OUTPUT_GET_INDEX_RAW
#endif
#ifdef OUTPUT_VIEW_OFFSET
#undef OUTPUT_VIEW_OFFSET
#endif
#ifdef OUTPUT_LENGTH
#undef OUTPUT_LENGTH
#endif
#ifdef OUTPUT_DIMS
#undef OUTPUT_DIMS
#endif
#ifdef OUTPUT_SIMPLE
#undef OUTPUT_SIMPLE
#endif
#ifdef OUTPUT_GROUPED
#undef OUTPUT_GROUPED
#endif
#ifdef OUTPUT_LAYOUT_BF
#undef OUTPUT_LAYOUT_BF
#endif
#ifdef OUTPUT_TYPE
#undef OUTPUT_TYPE
#endif
#ifdef OUTPUT_VAL_MAX
#undef OUTPUT_VAL_MAX
#endif
#ifdef OUTPUT_VAL_MIN
#undef OUTPUT_VAL_MIN
#endif
#ifdef OUTPUT_VAL_ONE
#undef OUTPUT_VAL_ONE
#endif
#ifdef OUTPUT_VAL_ZERO
#undef OUTPUT_VAL_ZERO
#endif
#ifdef TO_OUTPUT_TYPE
#undef TO_OUTPUT_TYPE
#endif
#ifdef TO_OUTPUT_TYPE_SAT
#undef TO_OUTPUT_TYPE_SAT
#endif
#ifdef AS_OUTPUT_TYPE
#undef AS_OUTPUT_TYPE
#endif
#ifdef OUTPUT_MAX_FUNC
#undef OUTPUT_MAX_FUNC
#endif
#ifdef OUTPUT_MIN_FUNC
#undef OUTPUT_MIN_FUNC
#endif
#ifdef OUTPUT_ABS_FUNC
#undef OUTPUT_ABS_FUNC
#endif
#ifdef OUTPUT_TYPE_SIZE
#undef OUTPUT_TYPE_SIZE
#endif
#ifdef OUTPUT_IS_FP
#undef OUTPUT_IS_FP
#endif
#ifdef OUTPUT_OFFSET
#undef OUTPUT_OFFSET
#endif
#ifdef OUTPUT_SIZES_DATA
#undef OUTPUT_SIZES_DATA
#endif
#ifdef OUTPUT_PITCHES
#undef OUTPUT_PITCHES
#endif
#ifdef OUTPUT_PAD_BEFORE
#undef OUTPUT_PAD_BEFORE
#endif
#ifdef OUTPUT_PAD_AFTER
#undef OUTPUT_PAD_AFTER
#endif
#ifdef OPTIONAL_SHAPE_INFO_ARG
#undef OPTIONAL_SHAPE_INFO_ARG
#endif
#ifdef OPTIONAL_SHAPE_INFO_TENSOR
#undef OPTIONAL_SHAPE_INFO_TENSOR
#endif
#ifdef FILTER_SIZE_X
#undef FILTER_SIZE_X
#endif
#ifdef FILTER_SIZE_Y
#undef FILTER_SIZE_Y
#endif
#ifdef FILTER_SIZE_Z
#undef FILTER_SIZE_Z
#endif
#ifdef FILTER_IFM_NUM
#undef FILTER_IFM_NUM
#endif
#ifdef FILTER_OFM_NUM
#undef FILTER_OFM_NUM
#endif
#ifdef FILTER_GROUPS_NUM
#undef FILTER_GROUPS_NUM
#endif
#ifdef FILTER_X_PITCH
#undef FILTER_X_PITCH
#endif
#ifdef FILTER_Y_PITCH
#undef FILTER_Y_PITCH
#endif
#ifdef FILTER_Z_PITCH
#undef FILTER_Z_PITCH
#endif
#ifdef FILTER_IFM_PITCH
#undef FILTER_IFM_PITCH
#endif
#ifdef FILTER_OFM_PITCH
#undef FILTER_OFM_PITCH
#endif
#ifdef FILTER_GROUPS_PITCH
#undef FILTER_GROUPS_PITCH
#endif
#ifdef FILTER_VIEW_OFFSET
#undef FILTER_VIEW_OFFSET
#endif
#ifdef FILTER_LENGTH
#undef FILTER_LENGTH
#endif
#ifdef FILTER_DIMS
#undef FILTER_DIMS
#endif
#ifdef FILTER_SIMPLE
#undef FILTER_SIMPLE
#endif
#ifdef FILTER_GROUPED
#undef FILTER_GROUPED
#endif
#ifdef FILTER_LAYOUT_OS_IYX_OSV32
#undef FILTER_LAYOUT_OS_IYX_OSV32
#endif
#ifdef FILTER_TYPE
#undef FILTER_TYPE
#endif
#ifdef FILTER_VAL_MAX
#undef FILTER_VAL_MAX
#endif
#ifdef FILTER_VAL_MIN
#undef FILTER_VAL_MIN
#endif
#ifdef FILTER_VAL_ONE
#undef FILTER_VAL_ONE
#endif
#ifdef FILTER_VAL_ZERO
#undef FILTER_VAL_ZERO
#endif
#ifdef TO_FILTER_TYPE
#undef TO_FILTER_TYPE
#endif
#ifdef TO_FILTER_TYPE_SAT
#undef TO_FILTER_TYPE_SAT
#endif
#ifdef AS_FILTER_TYPE
#undef AS_FILTER_TYPE
#endif
#ifdef FILTER_MAX_FUNC
#undef FILTER_MAX_FUNC
#endif
#ifdef FILTER_MIN_FUNC
#undef FILTER_MIN_FUNC
#endif
#ifdef FILTER_ABS_FUNC
#undef FILTER_ABS_FUNC
#endif
#ifdef FILTER_TYPE_SIZE
#undef FILTER_TYPE_SIZE
#endif
#ifdef FILTER_IS_FP
#undef FILTER_IS_FP
#endif
#ifdef FILTER_OFFSET
#undef FILTER_OFFSET
#endif
#ifdef FILTER_SIZES_DATA
#undef FILTER_SIZES_DATA
#endif
#ifdef FILTER_PITCHES
#undef FILTER_PITCHES
#endif
#ifdef FILTER_PAD_BEFORE
#undef FILTER_PAD_BEFORE
#endif
#ifdef FILTER_PAD_AFTER
#undef FILTER_PAD_AFTER
#endif
#ifdef BIAS_TERM
#undef BIAS_TERM
#endif
#ifdef BIAS_SIZE_X
#undef BIAS_SIZE_X
#endif
#ifdef BIAS_SIZE_Y
#undef BIAS_SIZE_Y
#endif
#ifdef BIAS_SIZE_Z
#undef BIAS_SIZE_Z
#endif
#ifdef BIAS_SIZE_W
#undef BIAS_SIZE_W
#endif
#ifdef BIAS_SIZE_U
#undef BIAS_SIZE_U
#endif
#ifdef BIAS_SIZE_V
#undef BIAS_SIZE_V
#endif
#ifdef BIAS_FEATURE_NUM
#undef BIAS_FEATURE_NUM
#endif
#ifdef BIAS_BATCH_NUM
#undef BIAS_BATCH_NUM
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_X
#undef BIAS_PAD_BEFORE_SIZE_X
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_Y
#undef BIAS_PAD_BEFORE_SIZE_Y
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_Z
#undef BIAS_PAD_BEFORE_SIZE_Z
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_W
#undef BIAS_PAD_BEFORE_SIZE_W
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_U
#undef BIAS_PAD_BEFORE_SIZE_U
#endif
#ifdef BIAS_PAD_BEFORE_SIZE_V
#undef BIAS_PAD_BEFORE_SIZE_V
#endif
#ifdef BIAS_PAD_BEFORE_FEATURE_NUM
#undef BIAS_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef BIAS_PAD_BEFORE_BATCH_NUM
#undef BIAS_PAD_BEFORE_BATCH_NUM
#endif
#ifdef BIAS_PAD_AFTER_SIZE_X
#undef BIAS_PAD_AFTER_SIZE_X
#endif
#ifdef BIAS_PAD_AFTER_SIZE_Y
#undef BIAS_PAD_AFTER_SIZE_Y
#endif
#ifdef BIAS_PAD_AFTER_SIZE_Z
#undef BIAS_PAD_AFTER_SIZE_Z
#endif
#ifdef BIAS_PAD_AFTER_SIZE_W
#undef BIAS_PAD_AFTER_SIZE_W
#endif
#ifdef BIAS_PAD_AFTER_SIZE_U
#undef BIAS_PAD_AFTER_SIZE_U
#endif
#ifdef BIAS_PAD_AFTER_SIZE_V
#undef BIAS_PAD_AFTER_SIZE_V
#endif
#ifdef BIAS_PAD_AFTER_FEATURE_NUM
#undef BIAS_PAD_AFTER_FEATURE_NUM
#endif
#ifdef BIAS_PAD_AFTER_BATCH_NUM
#undef BIAS_PAD_AFTER_BATCH_NUM
#endif
#ifdef BIAS_X_PITCH
#undef BIAS_X_PITCH
#endif
#ifdef BIAS_Y_PITCH
#undef BIAS_Y_PITCH
#endif
#ifdef BIAS_Z_PITCH
#undef BIAS_Z_PITCH
#endif
#ifdef BIAS_W_PITCH
#undef BIAS_W_PITCH
#endif
#ifdef BIAS_U_PITCH
#undef BIAS_U_PITCH
#endif
#ifdef BIAS_V_PITCH
#undef BIAS_V_PITCH
#endif
#ifdef BIAS_FEATURE_PITCH
#undef BIAS_FEATURE_PITCH
#endif
#ifdef BIAS_BATCH_PITCH
#undef BIAS_BATCH_PITCH
#endif
#ifdef BIAS_GET_INDEX_SAFE
#undef BIAS_GET_INDEX_SAFE
#endif
#ifdef BIAS_GET_INDEX
#undef BIAS_GET_INDEX
#endif
#ifdef BIAS_GET_INDEX_RAW
#undef BIAS_GET_INDEX_RAW
#endif
#ifdef BIAS_VIEW_OFFSET
#undef BIAS_VIEW_OFFSET
#endif
#ifdef BIAS_LENGTH
#undef BIAS_LENGTH
#endif
#ifdef BIAS_DIMS
#undef BIAS_DIMS
#endif
#ifdef BIAS_SIMPLE
#undef BIAS_SIMPLE
#endif
#ifdef BIAS_GROUPED
#undef BIAS_GROUPED
#endif
#ifdef BIAS_LAYOUT_BF
#undef BIAS_LAYOUT_BF
#endif
#ifdef BIAS_TYPE
#undef BIAS_TYPE
#endif
#ifdef BIAS_VAL_MAX
#undef BIAS_VAL_MAX
#endif
#ifdef BIAS_VAL_MIN
#undef BIAS_VAL_MIN
#endif
#ifdef BIAS_VAL_ONE
#undef BIAS_VAL_ONE
#endif
#ifdef BIAS_VAL_ZERO
#undef BIAS_VAL_ZERO
#endif
#ifdef TO_BIAS_TYPE
#undef TO_BIAS_TYPE
#endif
#ifdef TO_BIAS_TYPE_SAT
#undef TO_BIAS_TYPE_SAT
#endif
#ifdef AS_BIAS_TYPE
#undef AS_BIAS_TYPE
#endif
#ifdef BIAS_MAX_FUNC
#undef BIAS_MAX_FUNC
#endif
#ifdef BIAS_MIN_FUNC
#undef BIAS_MIN_FUNC
#endif
#ifdef BIAS_ABS_FUNC
#undef BIAS_ABS_FUNC
#endif
#ifdef BIAS_TYPE_SIZE
#undef BIAS_TYPE_SIZE
#endif
#ifdef BIAS_IS_FP
#undef BIAS_IS_FP
#endif
#ifdef BIAS_OFFSET
#undef BIAS_OFFSET
#endif
#ifdef BIAS_SIZES_DATA
#undef BIAS_SIZES_DATA
#endif
#ifdef BIAS_PITCHES
#undef BIAS_PITCHES
#endif
#ifdef BIAS_PAD_BEFORE
#undef BIAS_PAD_BEFORE
#endif
#ifdef BIAS_PAD_AFTER
#undef BIAS_PAD_AFTER
#endif
#ifdef BIAS_PER_OUTPUT
#undef BIAS_PER_OUTPUT
#endif
#ifdef BIAS_PER_OFM
#undef BIAS_PER_OFM
#endif
#ifdef INPUT0_ELEMENTS_COUNT
#undef INPUT0_ELEMENTS_COUNT
#endif
#ifdef SIMD
#undef SIMD
#endif
#ifdef TILE_B
#undef TILE_B
#endif
#ifdef TILE_OFM
#undef TILE_OFM
#endif
#ifdef TILE_IFM
#undef TILE_IFM
#endif
#ifdef TILE_K
#undef TILE_K
#endif
#ifdef TILE_K_OFM
#undef TILE_K_OFM
#endif
#ifdef DISPATCH_BSV
#undef DISPATCH_BSV
#endif
#ifdef DISPATCH_FSV
#undef DISPATCH_FSV
#endif
#ifdef CONST_LOOP_CALL
#undef CONST_LOOP_CALL
#endif
#ifdef CONST_LOOP_1
#undef CONST_LOOP_1
#endif
#ifdef CONST_LOOP_2
#undef CONST_LOOP_2
#endif
#ifdef CONST_LOOP_3
#undef CONST_LOOP_3
#endif
#ifdef CONST_LOOP_4
#undef CONST_LOOP_4
#endif
#ifdef CONST_LOOP_5
#undef CONST_LOOP_5
#endif
#ifdef CONST_LOOP
#undef CONST_LOOP
#endif
#ifdef REALIGN_FP16_OFFSET
#undef REALIGN_FP16_OFFSET
#endif
#ifdef ACTIVATION_TYPE
#undef ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_VAL_MAX
#undef ACTIVATION_VAL_MAX
#endif
#ifdef ACTIVATION_VAL_MIN
#undef ACTIVATION_VAL_MIN
#endif
#ifdef ACTIVATION_VAL_ONE
#undef ACTIVATION_VAL_ONE
#endif
#ifdef ACTIVATION_VAL_ZERO
#undef ACTIVATION_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_TYPE
#undef TO_ACTIVATION_TYPE
#endif
#ifdef TO_ACTIVATION_TYPE_SAT
#undef TO_ACTIVATION_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_TYPE
#undef AS_ACTIVATION_TYPE
#endif
#ifdef ACTIVATION_MAX_FUNC
#undef ACTIVATION_MAX_FUNC
#endif
#ifdef ACTIVATION_MIN_FUNC
#undef ACTIVATION_MIN_FUNC
#endif
#ifdef ACTIVATION_ABS_FUNC
#undef ACTIVATION_ABS_FUNC
#endif
#ifdef ACTIVATION_TYPE_SIZE
#undef ACTIVATION_TYPE_SIZE
#endif
#ifdef ACTIVATION_IS_FP
#undef ACTIVATION_IS_FP
#endif
#ifdef NL_M_TYPED_0
#undef NL_M_TYPED_0
#endif
#ifdef NL_N_TYPED_0
#undef NL_N_TYPED_0
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_TYPE
#undef ACTIVATION_FUNC_TYPED_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_MAX
#undef ACTIVATION_FUNC_TYPED_0_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_MIN
#undef ACTIVATION_FUNC_TYPED_0_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_ONE
#undef ACTIVATION_FUNC_TYPED_0_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_VAL_ZERO
#undef ACTIVATION_FUNC_TYPED_0_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_0_TYPE
#undef TO_ACTIVATION_FUNC_TYPED_0_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_0_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPED_0_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPED_0_TYPE
#undef AS_ACTIVATION_FUNC_TYPED_0_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_MAX_FUNC
#undef ACTIVATION_FUNC_TYPED_0_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_MIN_FUNC
#undef ACTIVATION_FUNC_TYPED_0_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_ABS_FUNC
#undef ACTIVATION_FUNC_TYPED_0_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPED_0_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_TYPED_0_IS_FP
#undef ACTIVATION_FUNC_TYPED_0_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_TYPED_0
#undef ACTIVATION_PARAMS_TYPED_0
#endif
#ifdef ACTIVATION_FUNC_TYPED_0
#undef ACTIVATION_FUNC_TYPED_0
#endif
#ifdef ACTIVATION_TYPED_0
#undef ACTIVATION_TYPED_0
#endif
#ifdef ACTIVATION_PARAMS_TYPED
#undef ACTIVATION_PARAMS_TYPED
#endif
#ifdef ACTIVATION_TYPED
#undef ACTIVATION_TYPED
#endif
#ifdef ACCUMULATOR_TYPE
#undef ACCUMULATOR_TYPE
#endif
#ifdef ACCUMULATOR_VAL_MAX
#undef ACCUMULATOR_VAL_MAX
#endif
#ifdef ACCUMULATOR_VAL_MIN
#undef ACCUMULATOR_VAL_MIN
#endif
#ifdef ACCUMULATOR_VAL_ONE
#undef ACCUMULATOR_VAL_ONE
#endif
#ifdef ACCUMULATOR_VAL_ZERO
#undef ACCUMULATOR_VAL_ZERO
#endif
#ifdef TO_ACCUMULATOR_TYPE
#undef TO_ACCUMULATOR_TYPE
#endif
#ifdef TO_ACCUMULATOR_TYPE_SAT
#undef TO_ACCUMULATOR_TYPE_SAT
#endif
#ifdef AS_ACCUMULATOR_TYPE
#undef AS_ACCUMULATOR_TYPE
#endif
#ifdef ACCUMULATOR_MAX_FUNC
#undef ACCUMULATOR_MAX_FUNC
#endif
#ifdef ACCUMULATOR_MIN_FUNC
#undef ACCUMULATOR_MIN_FUNC
#endif
#ifdef ACCUMULATOR_ABS_FUNC
#undef ACCUMULATOR_ABS_FUNC
#endif
#ifdef ACCUMULATOR_TYPE_SIZE
#undef ACCUMULATOR_TYPE_SIZE
#endif
#ifdef ACCUMULATOR_IS_FP
#undef ACCUMULATOR_IS_FP
#endif
#ifdef TILE_OUT_F_NUM
#undef TILE_OUT_F_NUM
#endif
#ifdef TILE_OUT_F_PITCH
#undef TILE_OUT_F_PITCH
#endif
#ifdef TILE_IN_B_PITCH
#undef TILE_IN_B_PITCH
#endif
#ifdef TILE_OUT_B_PITCH
#undef TILE_OUT_B_PITCH
#endif
#ifdef BATCH_SIZE
#undef BATCH_SIZE
#endif

//====================================================
// Kernel template: reorder_data 
// Kernel name: reorder_data_5570928500925804313_0
#define KERNEL(name) __kernel void reorder_data_5570928500925804313_0
#define FUNC(name)  _##name##_reorder_data_5570928500925804313_0
#define FUNC_CALL(name)  _##name##_reorder_data_5570928500925804313_0
#define CONST_ARRAY_DECL(name) __constant size_t  _##name##_reorder_data_5570928500925804313_0 []
#define CONST_ARRAY_REF(name)  _##name##_reorder_data_5570928500925804313_0
#define FP64_SUPPORTED 0
#define FP16_SUPPORTED 1
#define FP16_UNIT_USED 1
#define INT8_UNIT_USED 0
#define INT32_UNIT_USED 0
#define INT64_UNIT_USED 0
#define UINT8_UNIT_USED 0
#define UINT32_UNIT_USED 0
#define UNIT_TYPE half
#define UNIT_VAL_MAX HALF_MAX
#define UNIT_VAL_MIN -UNIT_VAL_MAX
#define UNIT_VAL_ONE 1.0h
#define UNIT_VAL_ZERO 0.0h
#define TO_UNIT_TYPE(v) convert_half(v)
#define TO_UNIT_TYPE_SAT(v) convert_half(v)
#define AS_UNIT_TYPE(v) as_half(v)
#define UNIT_MAX_FUNC fmax
#define UNIT_MIN_FUNC fmin
#define UNIT_ABS_FUNC fabs
#define UNIT_TYPE_SIZE 2
#define UNIT_IS_FP 1
#define NL_M as_float(0x0)/*0.000000e+00*/
#define NL_N as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPE half
#define ACTIVATION_FUNC_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_VAL_MIN -ACTIVATION_FUNC_VAL_MAX
#define ACTIVATION_FUNC_VAL_ONE 1.0h
#define ACTIVATION_FUNC_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_MAX_FUNC fmax
#define ACTIVATION_FUNC_MIN_FUNC fmin
#define ACTIVATION_FUNC_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPE_SIZE 2
#define ACTIVATION_FUNC_IS_FP 1
#define ACTIVATION_PARAMS NL_M, NL_N
#define ACTIVATION_FUNC(input, m, n) input
#define ACTIVATION(input, params) ACTIVATION_FUNC(input, params)
#define INPUT0_SIZE_X 1
#define INPUT0_SIZE_Y 1
#define INPUT0_SIZE_Z 1
#define INPUT0_SIZE_W 1
#define INPUT0_SIZE_U 1
#define INPUT0_SIZE_V 1
#define INPUT0_FEATURE_NUM 64
#define INPUT0_BATCH_NUM 10
#define INPUT0_PAD_BEFORE_SIZE_X 0
#define INPUT0_PAD_BEFORE_SIZE_Y 0
#define INPUT0_PAD_BEFORE_SIZE_Z 0
#define INPUT0_PAD_BEFORE_SIZE_W 0
#define INPUT0_PAD_BEFORE_SIZE_U 0
#define INPUT0_PAD_BEFORE_SIZE_V 0
#define INPUT0_PAD_BEFORE_FEATURE_NUM 0
#define INPUT0_PAD_BEFORE_BATCH_NUM 0
#define INPUT0_PAD_AFTER_SIZE_X 0
#define INPUT0_PAD_AFTER_SIZE_Y 0
#define INPUT0_PAD_AFTER_SIZE_Z 0
#define INPUT0_PAD_AFTER_SIZE_W 0
#define INPUT0_PAD_AFTER_SIZE_U 0
#define INPUT0_PAD_AFTER_SIZE_V 0
#define INPUT0_PAD_AFTER_FEATURE_NUM 0
#define INPUT0_PAD_AFTER_BATCH_NUM 0
#define INPUT0_X_PITCH 1
#define INPUT0_Y_PITCH 1
#define INPUT0_Z_PITCH 1
#define INPUT0_W_PITCH 1
#define INPUT0_U_PITCH 1
#define INPUT0_V_PITCH 1
#define INPUT0_FEATURE_PITCH 1
#define INPUT0_BATCH_PITCH 64
#define INPUT0_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX(b, f, y, x) GET_DATA_INDEX(INPUT0, b, f, y, x)
#define INPUT0_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(INPUT0, b, f, y, x)
#define INPUT0_VIEW_OFFSET 0
#define INPUT0_LENGTH 640
#define INPUT0_DIMS 4
#define INPUT0_SIMPLE 1
#define INPUT0_GROUPED 0
#define INPUT0_LAYOUT_BFYX 1
#define INPUT0_TYPE float
#define INPUT0_VAL_MAX FLT_MAX
#define INPUT0_VAL_MIN -INPUT0_VAL_MAX
#define INPUT0_VAL_ONE 1.0f
#define INPUT0_VAL_ZERO 0.0f
#define TO_INPUT0_TYPE(v) convert_float(v)
#define TO_INPUT0_TYPE_SAT(v) convert_float(v)
#define AS_INPUT0_TYPE(v) as_float(v)
#define INPUT0_MAX_FUNC fmax
#define INPUT0_MIN_FUNC fmin
#define INPUT0_ABS_FUNC fabs
#define INPUT0_TYPE_SIZE 4
#define INPUT0_IS_FP 1
#define INPUT0_OFFSET 0
#define INPUT0_SIZES_DATA { 1,1,64,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(INPUT0_SIZES) = INPUT0_SIZES_DATA;
#define INPUT0_SIZES CONST_ARRAY_REF(INPUT0_SIZES)
#define INPUT0_PITCHES (size_t []){ 1,1,1,64,1,1,1,1,1, } 
#define INPUT0_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define INPUT0_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_SIZE_X 1
#define OUTPUT_SIZE_Y 1
#define OUTPUT_SIZE_Z 1
#define OUTPUT_SIZE_W 1
#define OUTPUT_SIZE_U 1
#define OUTPUT_SIZE_V 1
#define OUTPUT_FEATURE_NUM 64
#define OUTPUT_BATCH_NUM 10
#define OUTPUT_PAD_BEFORE_SIZE_X 0
#define OUTPUT_PAD_BEFORE_SIZE_Y 0
#define OUTPUT_PAD_BEFORE_SIZE_Z 0
#define OUTPUT_PAD_BEFORE_SIZE_W 0
#define OUTPUT_PAD_BEFORE_SIZE_U 0
#define OUTPUT_PAD_BEFORE_SIZE_V 0
#define OUTPUT_PAD_BEFORE_FEATURE_NUM 0
#define OUTPUT_PAD_BEFORE_BATCH_NUM 0
#define OUTPUT_PAD_AFTER_SIZE_X 0
#define OUTPUT_PAD_AFTER_SIZE_Y 0
#define OUTPUT_PAD_AFTER_SIZE_Z 0
#define OUTPUT_PAD_AFTER_SIZE_W 0
#define OUTPUT_PAD_AFTER_SIZE_U 0
#define OUTPUT_PAD_AFTER_SIZE_V 0
#define OUTPUT_PAD_AFTER_FEATURE_NUM 0
#define OUTPUT_PAD_AFTER_BATCH_NUM 0
#define OUTPUT_X_PITCH 1
#define OUTPUT_Y_PITCH 1
#define OUTPUT_Z_PITCH 1
#define OUTPUT_W_PITCH 1
#define OUTPUT_U_PITCH 1
#define OUTPUT_V_PITCH 1
#define OUTPUT_FEATURE_PITCH 1
#define OUTPUT_BATCH_PITCH 64
#define OUTPUT_GET_INDEX_SAFE(b, f, y, x) GET_DATA_INDEX_SAFE(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX(b, f, y, x) GET_DATA_INDEX(OUTPUT, b, f, y, x)
#define OUTPUT_GET_INDEX_RAW(b, f, y, x) GET_DATA_INDEX_RAW(OUTPUT, b, f, y, x)
#define OUTPUT_VIEW_OFFSET 0
#define OUTPUT_LENGTH 640
#define OUTPUT_DIMS 4
#define OUTPUT_SIMPLE 1
#define OUTPUT_GROUPED 0
#define OUTPUT_LAYOUT_BFYX 1
#define OUTPUT_TYPE half
#define OUTPUT_VAL_MAX HALF_MAX
#define OUTPUT_VAL_MIN -OUTPUT_VAL_MAX
#define OUTPUT_VAL_ONE 1.0h
#define OUTPUT_VAL_ZERO 0.0h
#define TO_OUTPUT_TYPE(v) convert_half(v)
#define TO_OUTPUT_TYPE_SAT(v) convert_half(v)
#define AS_OUTPUT_TYPE(v) as_half(v)
#define OUTPUT_MAX_FUNC fmax
#define OUTPUT_MIN_FUNC fmin
#define OUTPUT_ABS_FUNC fabs
#define OUTPUT_TYPE_SIZE 2
#define OUTPUT_IS_FP 1
#define OUTPUT_OFFSET 0
#define OUTPUT_SIZES_DATA { 1,1,64,10,1,1,1,1,1, } 
CONST_ARRAY_DECL(OUTPUT_SIZES) = OUTPUT_SIZES_DATA;
#define OUTPUT_SIZES CONST_ARRAY_REF(OUTPUT_SIZES)
#define OUTPUT_PITCHES (size_t []){ 1,1,1,64,1,1,1,1,1, } 
#define OUTPUT_PAD_BEFORE (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OUTPUT_PAD_AFTER (size_t []){ 0,0,0,0,0,0,0,0,0, } 
#define OPTIONAL_SHAPE_INFO_ARG 
#define OPTIONAL_SHAPE_INFO_TENSOR 
#define MEAN_SUBTRACT_NONE 1
#define CALC_TYPE float
#define CALC_VAL_MAX FLT_MAX
#define CALC_VAL_MIN -CALC_VAL_MAX
#define CALC_VAL_ONE 1.0f
#define CALC_VAL_ZERO 0.0f
#define TO_CALC_TYPE(v) convert_float(v)
#define TO_CALC_TYPE_SAT(v) convert_float(v)
#define AS_CALC_TYPE(v) as_float(v)
#define CALC_MAX_FUNC fmax
#define CALC_MIN_FUNC fmin
#define CALC_ABS_FUNC fabs
#define CALC_TYPE_SIZE 4
#define CALC_IS_FP 1
#define INPUT_REORDER_TYPE float
#define INPUT_REORDER_VAL_MAX FLT_MAX
#define INPUT_REORDER_VAL_MIN -INPUT_REORDER_VAL_MAX
#define INPUT_REORDER_VAL_ONE 1.0f
#define INPUT_REORDER_VAL_ZERO 0.0f
#define TO_INPUT_REORDER_TYPE(v) convert_float(v)
#define TO_INPUT_REORDER_TYPE_SAT(v) convert_float(v)
#define AS_INPUT_REORDER_TYPE(v) as_float(v)
#define INPUT_REORDER_MAX_FUNC fmax
#define INPUT_REORDER_MIN_FUNC fmin
#define INPUT_REORDER_ABS_FUNC fabs
#define INPUT_REORDER_TYPE_SIZE 4
#define INPUT_REORDER_IS_FP 1
#define OUTPUT_REORDER_TYPE half
#define OUTPUT_REORDER_VAL_MAX HALF_MAX
#define OUTPUT_REORDER_VAL_MIN -OUTPUT_REORDER_VAL_MAX
#define OUTPUT_REORDER_VAL_ONE 1.0h
#define OUTPUT_REORDER_VAL_ZERO 0.0h
#define TO_OUTPUT_REORDER_TYPE(v) convert_half(v)
#define TO_OUTPUT_REORDER_TYPE_SAT(v) convert_half(v)
#define AS_OUTPUT_REORDER_TYPE(v) as_half(v)
#define OUTPUT_REORDER_MAX_FUNC fmax
#define OUTPUT_REORDER_MIN_FUNC fmin
#define OUTPUT_REORDER_ABS_FUNC fabs
#define OUTPUT_REORDER_TYPE_SIZE 2
#define OUTPUT_REORDER_IS_FP 1
#define MEAN_OP(val, mean_val) val-mean_val
#define NL_M_TYPED as_float(0x0)/*0.000000e+00*/
#define NL_N_TYPED as_float(0x0)/*0.000000e+00*/
#define ACTIVATION_FUNC_TYPED_TYPE half
#define ACTIVATION_FUNC_TYPED_VAL_MAX HALF_MAX
#define ACTIVATION_FUNC_TYPED_VAL_MIN -ACTIVATION_FUNC_TYPED_VAL_MAX
#define ACTIVATION_FUNC_TYPED_VAL_ONE 1.0h
#define ACTIVATION_FUNC_TYPED_VAL_ZERO 0.0h
#define TO_ACTIVATION_FUNC_TYPED_TYPE(v) convert_half(v)
#define TO_ACTIVATION_FUNC_TYPED_TYPE_SAT(v) convert_half(v)
#define AS_ACTIVATION_FUNC_TYPED_TYPE(v) as_half(v)
#define ACTIVATION_FUNC_TYPED_MAX_FUNC fmax
#define ACTIVATION_FUNC_TYPED_MIN_FUNC fmin
#define ACTIVATION_FUNC_TYPED_ABS_FUNC fabs
#define ACTIVATION_FUNC_TYPED_TYPE_SIZE 2
#define ACTIVATION_FUNC_TYPED_IS_FP 1
#define ACTIVATION_PARAMS_TYPED NL_M_TYPED, NL_N_TYPED
#define ACTIVATION_FUNC_TYPED(jit_type, input, m, n) input
#define ACTIVATION_TYPED(jit_type, input, params) ACTIVATION_FUNC_TYPED(jit_type, input, params)
#define SUB_GROUP_SIZE 1
#define GWS_BATCH 2
#define GWS_FEATURE 1
#define GWS_YX 0


inline uint8 FUNC(reshape_dims)(
 uint b, uint f, uint v, uint u, uint w, uint z, uint y, uint x,
 uint src_size_f, uint src_size_v, uint src_size_u, uint src_size_w, uint src_size_z, uint src_size_y, uint src_size_x,
 uint dst_size_f, uint dst_size_v, uint dst_size_u, uint dst_size_w, uint dst_size_z, uint dst_size_y, uint dst_size_x,
 uint src_dims, uint dst_dims)
{
 if (dst_dims == src_dims) {
 return (uint8)(b, f, v, u, w, z, y, x);
 }
 const uint src_pitch_x = 1;
 const uint src_pitch_y = src_pitch_x * src_size_x;
 const uint src_pitch_z = src_pitch_y * src_size_y;
 const uint src_pitch_w = src_pitch_z * src_size_z;
 const uint src_pitch_u = src_pitch_w * src_size_w;
 const uint src_pitch_v = src_pitch_u * src_size_u;
 const uint src_pitch_f = src_pitch_v * src_size_v;
 const uint src_pitch_b = src_pitch_f * src_size_f;
 uint flat_idx = x * src_pitch_x
 + y * src_pitch_y
 + z * src_pitch_z
 + w * src_pitch_w
 + u * src_pitch_u
 + v * src_pitch_v
 + f * src_pitch_f
 + b * src_pitch_b;
 uint dst_x = flat_idx % dst_size_x;
 flat_idx /= dst_size_x;
 uint dst_y = flat_idx % dst_size_y;
 flat_idx /= dst_size_y;
 uint dst_z = flat_idx % dst_size_z;
 flat_idx /= dst_size_z;
 uint dst_w = flat_idx % dst_size_w;
 flat_idx /= dst_size_w;
 uint dst_u = flat_idx % dst_size_u;
 flat_idx /= dst_size_u;
 uint dst_v = flat_idx % dst_size_v;
 flat_idx /= dst_size_v;
 uint dst_f = flat_idx % dst_size_f;
 flat_idx /= dst_size_f;
 uint dst_b = flat_idx;
 return (uint8)(dst_b, dst_f, dst_v, dst_u, dst_w, dst_z, dst_y, dst_x);
}
#define RESHAPE_DIMS(src_prefix, dst_prefix, b, f, v, u, w, z, y, x) FUNC_CALL(reshape_dims)( b, f, v, u, w, z, y, x, CAT(src_prefix, _FEATURE_NUM), CAT(src_prefix, _SIZE_V), CAT(src_prefix, _SIZE_U), CAT(src_prefix, _SIZE_W), CAT(src_prefix, _SIZE_Z), CAT(src_prefix, _SIZE_Y), CAT(src_prefix, _SIZE_X), CAT(dst_prefix, _FEATURE_NUM), CAT(dst_prefix, _SIZE_V), CAT(dst_prefix, _SIZE_U), CAT(dst_prefix, _SIZE_W), CAT(dst_prefix, _SIZE_Z), CAT(dst_prefix, _SIZE_Y), CAT(dst_prefix, _SIZE_X), CAT(src_prefix, _DIMS), CAT(dst_prefix, _DIMS))
inline uint FUNC(get_input_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint v, uint u, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
#if INPUT0_DIMS < 5
 return INPUT0_GET_INDEX(b, f, y, x);
#elif INPUT0_DIMS == 5
 return INPUT0_GET_INDEX(b, f, z, y, x);
#elif INPUT0_DIMS == 6
 return INPUT0_GET_INDEX(b, f, w, z, y, x);
#elif INPUT0_DIMS == 7
 return INPUT0_GET_INDEX(b, f, u, w, z, y, x);
#elif INPUT0_DIMS == 8
 return INPUT0_GET_INDEX(b, f, v, u, w, z, y, x);
#else
#error [GPU] Unsupported input tensor rank in get_input_index function
#endif
}
inline uint FUNC(get_input_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
 return FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, f, 0, 0, w, z, y, x);
}
inline uint FUNC(get_output_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint v, uint u, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
#if OUTPUT_DIMS < 5
 return OUTPUT_GET_INDEX(b, f, y, x);
#elif OUTPUT_DIMS == 5
 return OUTPUT_GET_INDEX(b, f, z, y, x);
#elif OUTPUT_DIMS == 6
 return OUTPUT_GET_INDEX(b, f, w, z, y, x);
#elif OUTPUT_DIMS == 7
 return OUTPUT_GET_INDEX(b, f, u, w, z, y, x);
#elif OUTPUT_DIMS == 8
 return OUTPUT_GET_INDEX(b, f, v, u, w, z, y, x);
#else
#error [GPU] Unsupported output tensor rank in get_output_index function
#endif
}
inline uint FUNC(get_output_index)(OPTIONAL_SHAPE_INFO_ARG uint b, uint f, uint w, uint z, uint y, uint x) __attribute__((overloadable)) {
 return FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR b, f, 0, 0, w, z, y, x);
}
#define DECLARE_SAMPLER const sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST
#if FP16_UNIT_USED
 #define IMAGE_READ(image, coord) read_imageh((image), imageSampler, (coord))
 #define IMAGE_WRITE(image, coord, val) write_imageh((image), (coord), (val))
#else
 #define IMAGE_READ(image, coord) read_imagef((image), imageSampler, (coord))
 #define IMAGE_WRITE(image, coord, val) write_imagef((image), (coord), (val))
#endif
#define INPUT_TYPE4 MAKE_VECTOR_TYPE(INPUT_REORDER_TYPE, 4)
#define OUTPUT_TYPE4 MAKE_VECTOR_TYPE(OUTPUT_REORDER_TYPE, 4)
KERNEL (reorder_data)(
 OPTIONAL_SHAPE_INFO_ARG
#if INPUT0_LAYOUT_NV12 || INPUT0_LAYOUT_IMAGE_2D_RGBA || SURFACE_INPUT
 read_only image2d_t input,
#else
 const __global INPUT_REORDER_TYPE* input,
#endif
#if OUTPUT_LAYOUT_IMAGE_2D_RGBA
 write_only image2d_t output
#else
 __global OUTPUT_REORDER_TYPE* output
#endif
#ifdef MEAN_SUBTRACT_IN_BUFFER
 , __global MEAN_SUBTRACT_TYPE* mean_subtract
#endif
 )
{
 const uint b = get_global_id(GWS_BATCH);
 const uint f = get_global_id(GWS_FEATURE);
#if INPUT0_DIMS == 2
 const uint y = 0;
 const uint x = 0;
 const uint z = 0;
 const uint w = 0;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 4
 const uint y = ((uint)(get_global_id(GWS_YX))) / INPUT0_SIZE_X;
 const uint x = ((uint)(get_global_id(GWS_YX))) % INPUT0_SIZE_X;
 const uint z = 0;
 const uint w = 0;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 5
 uint data_idx = get_global_id(GWS_YX);
 uint tmp_data_idx = data_idx / INPUT0_SIZE_X;
 const uint x = data_idx - tmp_data_idx * INPUT0_SIZE_X;
 data_idx = tmp_data_idx;
 tmp_data_idx = data_idx / INPUT0_SIZE_Y;
 const uint y = data_idx - tmp_data_idx * INPUT0_SIZE_Y;
 data_idx = tmp_data_idx;
 tmp_data_idx = data_idx / INPUT0_SIZE_Z;
 const uint z = data_idx - tmp_data_idx * INPUT0_SIZE_Z;
 const uint w = 0;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 6
 const uint gid_yx = (uint)(get_global_id(GWS_YX));
 const uint x = gid_yx % INPUT0_SIZE_X;
 const uint y = gid_yx / INPUT0_SIZE_X % INPUT0_SIZE_Y;
 const uint z = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y % INPUT0_SIZE_Z;
 const uint w = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z % INPUT0_SIZE_W;
 const uint u = 0;
 const uint v = 0;
#elif INPUT0_DIMS == 7
 const uint gid_yx = (uint)(get_global_id(GWS_YX));
 const uint x = gid_yx % INPUT0_SIZE_X;
 const uint y = gid_yx / INPUT0_SIZE_X % INPUT0_SIZE_Y;
 const uint z = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y % INPUT0_SIZE_Z;
 const uint w = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z % INPUT0_SIZE_W;
 const uint u = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z / INPUT0_SIZE_W % INPUT0_SIZE_U;
 const uint v = 0;
#elif INPUT0_DIMS == 8
 const uint gid_yx = (uint)(get_global_id(GWS_YX));
 const uint x = gid_yx % INPUT0_SIZE_X;
 const uint y = gid_yx / INPUT0_SIZE_X % INPUT0_SIZE_Y;
 const uint z = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y % INPUT0_SIZE_Z;
 const uint w = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z % INPUT0_SIZE_W;
 const uint u = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z / INPUT0_SIZE_W % INPUT0_SIZE_U;
 const uint v = gid_yx / INPUT0_SIZE_X / INPUT0_SIZE_Y / INPUT0_SIZE_Z / INPUT0_SIZE_W / INPUT0_SIZE_U % INPUT0_SIZE_V;
#endif
#if defined INPUT0_LAYOUT_NV12 && !SURFACE_INPUT
 const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
 float4 colorVYU = read_imagef(input, sampler, (int2)(x, y));
 float Ycomponent = mad(colorVYU.s1, 296.82f, -18.624f);
 float Ucomponent = mad(colorVYU.s2, 255.0f, -128.f);
 float Vcomponent = mad(colorVYU.s0, 255.0f, -128.f);
 float B = clamp(mad(Vcomponent, 1.596f, Ycomponent), 0.f, 255.f);
 float R = clamp(mad(Ucomponent, 2.018f, Ycomponent), 0.f, 255.f);
 float G = clamp(mad(Vcomponent, -0.813f, mad(Ucomponent, -0.391f, Ycomponent)), 0.f, 255.f);
#elif defined INPUT0_LAYOUT_IMAGE_2D_RGBA
 const sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
 OUTPUT_TYPE4 colorRGBA = IMAGE_READ(input, (int2)(x, y));
#elif defined OUTPUT_LAYOUT_IMAGE_2D_RGBA
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, f, v, u, w, z, y, x);
 const uint input_idx_R = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 0, v, u, w, z, y, x);
 const uint input_idx_G = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 1, v, u, w, z, y, x);
 const uint input_idx_B = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 2, v, u, w, z, y, x);
#if OUTPUT_FEATURE_NUM == 3
 INPUT_TYPE4 colorRGBA = { TO_INPUT_REORDER_TYPE(input[input_idx_R]), TO_INPUT_REORDER_TYPE(input[input_idx_G]), TO_INPUT_REORDER_TYPE(input[input_idx_B]), TO_INPUT_REORDER_TYPE(0.f) };
#else
 const uint input_idx_A = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, 3, v, u, w, z, y, x);
 INPUT_TYPE4 colorRGBA = { TO_INPUT_REORDER_TYPE(input[input_idx_R]), TO_INPUT_REORDER_TYPE(input[input_idx_G]), TO_INPUT_REORDER_TYPE(input[input_idx_B]), TO_INPUT_REORDER_TYPE(input[input_idx_A]) };
#endif
#else
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, f, v, u, w, z, y, x);
 const uint input_idx = FUNC_CALL(get_input_index)(OPTIONAL_SHAPE_INFO_TENSOR b, f, v, u, w, z, y, x);
 const uint output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
#if defined MEAN_SUBTRACT_INSIDE_PARAMS
 float res = TO_MEAN_TYPE(input[input_idx]);
 res = MEAN_OP(res, VALUE_TO_SUBTRACT[f % VALUE_TO_SUBTRACT_SIZE]);
#elif defined MEAN_SUBTRACT_IN_BUFFER
#if defined MEAN_PER_FEATURE
 MEAN_SUBTRACT_TYPE res = TO_MEAN_TYPE(input[input_idx]);
 res = MEAN_OP(res, mean_subtract[f]);
#else
 MEAN_SUBTRACT_TYPE res = TO_MEAN_TYPE(input[input_idx]);
 uint8 msv = RESHAPE_DIMS(INPUT0, MEAN_SUBTRACT, b, f, v, u, w, z, y, x);
 res = MEAN_OP(res, mean_subtract[GET_DATA_INDEX_SAFE(MEAN_SUBTRACT, msv.s0, msv.s1, msv.s6, msv.s7)]);
#endif
#elif SURFACE_INPUT
 float4 Y = read_imagef(input, (int2)(x, y));
 float Ycomponent = mad(Y.x, 296.82f, -18.624f);
 float res = clamp(Ycomponent, 0.f, 255.f);
#else
 CALC_TYPE res = TO_CALC_TYPE(input[input_idx]);
#endif
#endif
#if defined INPUT0_LAYOUT_NV12 && !SURFACE_INPUT
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 0, v, u, w, z, y, x);
 uint output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(R), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 1, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(G), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 2, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(B), NL_M, NL_N);
#elif INPUT0_LAYOUT_IMAGE_2D_RGBA
 uint8 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 0, v, u, w, z, y, x);
 uint output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s0), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 1, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s1), NL_M, NL_N);
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 2, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s2), NL_M, NL_N);
#if INPUT0_FEATURE_NUM == 4
 ov = RESHAPE_DIMS(INPUT0, OUTPUT, b, 3, v, u, w, z, y, x);
 output_idx = FUNC_CALL(get_output_index)(OPTIONAL_SHAPE_INFO_TENSOR ov.s0, ov.s1, ov.s2, ov.s3, ov.s4, ov.s5, ov.s6, ov.s7);
 output[output_idx] = ACTIVATION_FUNC_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(colorRGBA.s3), NL_M, NL_N);
#endif
#elif OUTPUT_LAYOUT_IMAGE_2D_RGBA
 IMAGE_WRITE(output, (int2)(x, y), colorRGBA);
#else
#if INPUT0_IS_FP && !OUTPUT_IS_FP
#if CONVERT_TRUNCATE
 output[output_idx] = ACTIVATION_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(convert_long(res)), ACTIVATION_PARAMS_TYPED);
#else
 output[output_idx] = ACTIVATION_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE_SAT(res), ACTIVATION_PARAMS_TYPED);
#endif
#else
 output[output_idx] = ACTIVATION_TYPED(OUTPUT_REORDER, TO_OUTPUT_REORDER_TYPE(res), ACTIVATION_PARAMS_TYPED);
#endif
#endif
}
#undef INPUT_TYPE4
#undef OUTPUT_TYPE4
#ifdef INPUT_TYPE4
#undef INPUT_TYPE4
#endif
#ifdef OUTPUT_TYPE4
#undef OUTPUT_TYPE4
#endif
#ifdef RESHAPE_DIMS
#undef RESHAPE_DIMS
#endif
#ifdef DECLARE_SAMPLER
#undef DECLARE_SAMPLER
#endif
#ifdef IMAGE_READ
#undef IMAGE_READ
#endif
#ifdef IMAGE_WRITE
#undef IMAGE_WRITE
#endif
#ifdef IMAGE_READ
#undef IMAGE_READ
#endif
#ifdef IMAGE_WRITE
#undef IMAGE_WRITE
#endif
#undef KERNEL
#undef FUNC
#undef FUNC_CALL
#undef CONST_ARRAY_DECL
#undef CONST_ARRAY_REF
#ifdef FP64_SUPPORTED
#undef FP64_SUPPORTED
#endif
#ifdef FP16_SUPPORTED
#undef FP16_SUPPORTED
#endif
#ifdef FP16_UNIT_USED
#undef FP16_UNIT_USED
#endif
#ifdef INT8_UNIT_USED
#undef INT8_UNIT_USED
#endif
#ifdef INT32_UNIT_USED
#undef INT32_UNIT_USED
#endif
#ifdef INT64_UNIT_USED
#undef INT64_UNIT_USED
#endif
#ifdef UINT8_UNIT_USED
#undef UINT8_UNIT_USED
#endif
#ifdef UINT32_UNIT_USED
#undef UINT32_UNIT_USED
#endif
#ifdef UNIT_TYPE
#undef UNIT_TYPE
#endif
#ifdef UNIT_VAL_MAX
#undef UNIT_VAL_MAX
#endif
#ifdef UNIT_VAL_MIN
#undef UNIT_VAL_MIN
#endif
#ifdef UNIT_VAL_ONE
#undef UNIT_VAL_ONE
#endif
#ifdef UNIT_VAL_ZERO
#undef UNIT_VAL_ZERO
#endif
#ifdef TO_UNIT_TYPE
#undef TO_UNIT_TYPE
#endif
#ifdef TO_UNIT_TYPE_SAT
#undef TO_UNIT_TYPE_SAT
#endif
#ifdef AS_UNIT_TYPE
#undef AS_UNIT_TYPE
#endif
#ifdef UNIT_MAX_FUNC
#undef UNIT_MAX_FUNC
#endif
#ifdef UNIT_MIN_FUNC
#undef UNIT_MIN_FUNC
#endif
#ifdef UNIT_ABS_FUNC
#undef UNIT_ABS_FUNC
#endif
#ifdef UNIT_TYPE_SIZE
#undef UNIT_TYPE_SIZE
#endif
#ifdef UNIT_IS_FP
#undef UNIT_IS_FP
#endif
#ifdef NL_M
#undef NL_M
#endif
#ifdef NL_N
#undef NL_N
#endif
#ifdef ACTIVATION_FUNC_TYPE
#undef ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_VAL_MAX
#undef ACTIVATION_FUNC_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_VAL_MIN
#undef ACTIVATION_FUNC_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_VAL_ONE
#undef ACTIVATION_FUNC_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_VAL_ZERO
#undef ACTIVATION_FUNC_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE
#undef TO_ACTIVATION_FUNC_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPE
#undef AS_ACTIVATION_FUNC_TYPE
#endif
#ifdef ACTIVATION_FUNC_MAX_FUNC
#undef ACTIVATION_FUNC_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_MIN_FUNC
#undef ACTIVATION_FUNC_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_ABS_FUNC
#undef ACTIVATION_FUNC_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_IS_FP
#undef ACTIVATION_FUNC_IS_FP
#endif
#ifdef ACTIVATION_PARAMS
#undef ACTIVATION_PARAMS
#endif
#ifdef ACTIVATION_FUNC
#undef ACTIVATION_FUNC
#endif
#ifdef ACTIVATION
#undef ACTIVATION
#endif
#ifdef INPUT0_SIZE_X
#undef INPUT0_SIZE_X
#endif
#ifdef INPUT0_SIZE_Y
#undef INPUT0_SIZE_Y
#endif
#ifdef INPUT0_SIZE_Z
#undef INPUT0_SIZE_Z
#endif
#ifdef INPUT0_SIZE_W
#undef INPUT0_SIZE_W
#endif
#ifdef INPUT0_SIZE_U
#undef INPUT0_SIZE_U
#endif
#ifdef INPUT0_SIZE_V
#undef INPUT0_SIZE_V
#endif
#ifdef INPUT0_FEATURE_NUM
#undef INPUT0_FEATURE_NUM
#endif
#ifdef INPUT0_BATCH_NUM
#undef INPUT0_BATCH_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_X
#undef INPUT0_PAD_BEFORE_SIZE_X
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Y
#undef INPUT0_PAD_BEFORE_SIZE_Y
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_Z
#undef INPUT0_PAD_BEFORE_SIZE_Z
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_W
#undef INPUT0_PAD_BEFORE_SIZE_W
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_U
#undef INPUT0_PAD_BEFORE_SIZE_U
#endif
#ifdef INPUT0_PAD_BEFORE_SIZE_V
#undef INPUT0_PAD_BEFORE_SIZE_V
#endif
#ifdef INPUT0_PAD_BEFORE_FEATURE_NUM
#undef INPUT0_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_BEFORE_BATCH_NUM
#undef INPUT0_PAD_BEFORE_BATCH_NUM
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_X
#undef INPUT0_PAD_AFTER_SIZE_X
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Y
#undef INPUT0_PAD_AFTER_SIZE_Y
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_Z
#undef INPUT0_PAD_AFTER_SIZE_Z
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_W
#undef INPUT0_PAD_AFTER_SIZE_W
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_U
#undef INPUT0_PAD_AFTER_SIZE_U
#endif
#ifdef INPUT0_PAD_AFTER_SIZE_V
#undef INPUT0_PAD_AFTER_SIZE_V
#endif
#ifdef INPUT0_PAD_AFTER_FEATURE_NUM
#undef INPUT0_PAD_AFTER_FEATURE_NUM
#endif
#ifdef INPUT0_PAD_AFTER_BATCH_NUM
#undef INPUT0_PAD_AFTER_BATCH_NUM
#endif
#ifdef INPUT0_X_PITCH
#undef INPUT0_X_PITCH
#endif
#ifdef INPUT0_Y_PITCH
#undef INPUT0_Y_PITCH
#endif
#ifdef INPUT0_Z_PITCH
#undef INPUT0_Z_PITCH
#endif
#ifdef INPUT0_W_PITCH
#undef INPUT0_W_PITCH
#endif
#ifdef INPUT0_U_PITCH
#undef INPUT0_U_PITCH
#endif
#ifdef INPUT0_V_PITCH
#undef INPUT0_V_PITCH
#endif
#ifdef INPUT0_FEATURE_PITCH
#undef INPUT0_FEATURE_PITCH
#endif
#ifdef INPUT0_BATCH_PITCH
#undef INPUT0_BATCH_PITCH
#endif
#ifdef INPUT0_GET_INDEX_SAFE
#undef INPUT0_GET_INDEX_SAFE
#endif
#ifdef INPUT0_GET_INDEX
#undef INPUT0_GET_INDEX
#endif
#ifdef INPUT0_GET_INDEX_RAW
#undef INPUT0_GET_INDEX_RAW
#endif
#ifdef INPUT0_VIEW_OFFSET
#undef INPUT0_VIEW_OFFSET
#endif
#ifdef INPUT0_LENGTH
#undef INPUT0_LENGTH
#endif
#ifdef INPUT0_DIMS
#undef INPUT0_DIMS
#endif
#ifdef INPUT0_SIMPLE
#undef INPUT0_SIMPLE
#endif
#ifdef INPUT0_GROUPED
#undef INPUT0_GROUPED
#endif
#ifdef INPUT0_LAYOUT_BFYX
#undef INPUT0_LAYOUT_BFYX
#endif
#ifdef INPUT0_TYPE
#undef INPUT0_TYPE
#endif
#ifdef INPUT0_VAL_MAX
#undef INPUT0_VAL_MAX
#endif
#ifdef INPUT0_VAL_MIN
#undef INPUT0_VAL_MIN
#endif
#ifdef INPUT0_VAL_ONE
#undef INPUT0_VAL_ONE
#endif
#ifdef INPUT0_VAL_ZERO
#undef INPUT0_VAL_ZERO
#endif
#ifdef TO_INPUT0_TYPE
#undef TO_INPUT0_TYPE
#endif
#ifdef TO_INPUT0_TYPE_SAT
#undef TO_INPUT0_TYPE_SAT
#endif
#ifdef AS_INPUT0_TYPE
#undef AS_INPUT0_TYPE
#endif
#ifdef INPUT0_MAX_FUNC
#undef INPUT0_MAX_FUNC
#endif
#ifdef INPUT0_MIN_FUNC
#undef INPUT0_MIN_FUNC
#endif
#ifdef INPUT0_ABS_FUNC
#undef INPUT0_ABS_FUNC
#endif
#ifdef INPUT0_TYPE_SIZE
#undef INPUT0_TYPE_SIZE
#endif
#ifdef INPUT0_IS_FP
#undef INPUT0_IS_FP
#endif
#ifdef INPUT0_OFFSET
#undef INPUT0_OFFSET
#endif
#ifdef INPUT0_SIZES_DATA
#undef INPUT0_SIZES_DATA
#endif
#ifdef INPUT0_PITCHES
#undef INPUT0_PITCHES
#endif
#ifdef INPUT0_PAD_BEFORE
#undef INPUT0_PAD_BEFORE
#endif
#ifdef INPUT0_PAD_AFTER
#undef INPUT0_PAD_AFTER
#endif
#ifdef OUTPUT_SIZE_X
#undef OUTPUT_SIZE_X
#endif
#ifdef OUTPUT_SIZE_Y
#undef OUTPUT_SIZE_Y
#endif
#ifdef OUTPUT_SIZE_Z
#undef OUTPUT_SIZE_Z
#endif
#ifdef OUTPUT_SIZE_W
#undef OUTPUT_SIZE_W
#endif
#ifdef OUTPUT_SIZE_U
#undef OUTPUT_SIZE_U
#endif
#ifdef OUTPUT_SIZE_V
#undef OUTPUT_SIZE_V
#endif
#ifdef OUTPUT_FEATURE_NUM
#undef OUTPUT_FEATURE_NUM
#endif
#ifdef OUTPUT_BATCH_NUM
#undef OUTPUT_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_X
#undef OUTPUT_PAD_BEFORE_SIZE_X
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Y
#undef OUTPUT_PAD_BEFORE_SIZE_Y
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_Z
#undef OUTPUT_PAD_BEFORE_SIZE_Z
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_W
#undef OUTPUT_PAD_BEFORE_SIZE_W
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_U
#undef OUTPUT_PAD_BEFORE_SIZE_U
#endif
#ifdef OUTPUT_PAD_BEFORE_SIZE_V
#undef OUTPUT_PAD_BEFORE_SIZE_V
#endif
#ifdef OUTPUT_PAD_BEFORE_FEATURE_NUM
#undef OUTPUT_PAD_BEFORE_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_BEFORE_BATCH_NUM
#undef OUTPUT_PAD_BEFORE_BATCH_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_X
#undef OUTPUT_PAD_AFTER_SIZE_X
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Y
#undef OUTPUT_PAD_AFTER_SIZE_Y
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_Z
#undef OUTPUT_PAD_AFTER_SIZE_Z
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_W
#undef OUTPUT_PAD_AFTER_SIZE_W
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_U
#undef OUTPUT_PAD_AFTER_SIZE_U
#endif
#ifdef OUTPUT_PAD_AFTER_SIZE_V
#undef OUTPUT_PAD_AFTER_SIZE_V
#endif
#ifdef OUTPUT_PAD_AFTER_FEATURE_NUM
#undef OUTPUT_PAD_AFTER_FEATURE_NUM
#endif
#ifdef OUTPUT_PAD_AFTER_BATCH_NUM
#undef OUTPUT_PAD_AFTER_BATCH_NUM
#endif
#ifdef OUTPUT_X_PITCH
#undef OUTPUT_X_PITCH
#endif
#ifdef OUTPUT_Y_PITCH
#undef OUTPUT_Y_PITCH
#endif
#ifdef OUTPUT_Z_PITCH
#undef OUTPUT_Z_PITCH
#endif
#ifdef OUTPUT_W_PITCH
#undef OUTPUT_W_PITCH
#endif
#ifdef OUTPUT_U_PITCH
#undef OUTPUT_U_PITCH
#endif
#ifdef OUTPUT_V_PITCH
#undef OUTPUT_V_PITCH
#endif
#ifdef OUTPUT_FEATURE_PITCH
#undef OUTPUT_FEATURE_PITCH
#endif
#ifdef OUTPUT_BATCH_PITCH
#undef OUTPUT_BATCH_PITCH
#endif
#ifdef OUTPUT_GET_INDEX_SAFE
#undef OUTPUT_GET_INDEX_SAFE
#endif
#ifdef OUTPUT_GET_INDEX
#undef OUTPUT_GET_INDEX
#endif
#ifdef OUTPUT_GET_INDEX_RAW
#undef OUTPUT_GET_INDEX_RAW
#endif
#ifdef OUTPUT_VIEW_OFFSET
#undef OUTPUT_VIEW_OFFSET
#endif
#ifdef OUTPUT_LENGTH
#undef OUTPUT_LENGTH
#endif
#ifdef OUTPUT_DIMS
#undef OUTPUT_DIMS
#endif
#ifdef OUTPUT_SIMPLE
#undef OUTPUT_SIMPLE
#endif
#ifdef OUTPUT_GROUPED
#undef OUTPUT_GROUPED
#endif
#ifdef OUTPUT_LAYOUT_BFYX
#undef OUTPUT_LAYOUT_BFYX
#endif
#ifdef OUTPUT_TYPE
#undef OUTPUT_TYPE
#endif
#ifdef OUTPUT_VAL_MAX
#undef OUTPUT_VAL_MAX
#endif
#ifdef OUTPUT_VAL_MIN
#undef OUTPUT_VAL_MIN
#endif
#ifdef OUTPUT_VAL_ONE
#undef OUTPUT_VAL_ONE
#endif
#ifdef OUTPUT_VAL_ZERO
#undef OUTPUT_VAL_ZERO
#endif
#ifdef TO_OUTPUT_TYPE
#undef TO_OUTPUT_TYPE
#endif
#ifdef TO_OUTPUT_TYPE_SAT
#undef TO_OUTPUT_TYPE_SAT
#endif
#ifdef AS_OUTPUT_TYPE
#undef AS_OUTPUT_TYPE
#endif
#ifdef OUTPUT_MAX_FUNC
#undef OUTPUT_MAX_FUNC
#endif
#ifdef OUTPUT_MIN_FUNC
#undef OUTPUT_MIN_FUNC
#endif
#ifdef OUTPUT_ABS_FUNC
#undef OUTPUT_ABS_FUNC
#endif
#ifdef OUTPUT_TYPE_SIZE
#undef OUTPUT_TYPE_SIZE
#endif
#ifdef OUTPUT_IS_FP
#undef OUTPUT_IS_FP
#endif
#ifdef OUTPUT_OFFSET
#undef OUTPUT_OFFSET
#endif
#ifdef OUTPUT_SIZES_DATA
#undef OUTPUT_SIZES_DATA
#endif
#ifdef OUTPUT_PITCHES
#undef OUTPUT_PITCHES
#endif
#ifdef OUTPUT_PAD_BEFORE
#undef OUTPUT_PAD_BEFORE
#endif
#ifdef OUTPUT_PAD_AFTER
#undef OUTPUT_PAD_AFTER
#endif
#ifdef OPTIONAL_SHAPE_INFO_ARG
#undef OPTIONAL_SHAPE_INFO_ARG
#endif
#ifdef OPTIONAL_SHAPE_INFO_TENSOR
#undef OPTIONAL_SHAPE_INFO_TENSOR
#endif
#ifdef MEAN_SUBTRACT_NONE
#undef MEAN_SUBTRACT_NONE
#endif
#ifdef CALC_TYPE
#undef CALC_TYPE
#endif
#ifdef CALC_VAL_MAX
#undef CALC_VAL_MAX
#endif
#ifdef CALC_VAL_MIN
#undef CALC_VAL_MIN
#endif
#ifdef CALC_VAL_ONE
#undef CALC_VAL_ONE
#endif
#ifdef CALC_VAL_ZERO
#undef CALC_VAL_ZERO
#endif
#ifdef TO_CALC_TYPE
#undef TO_CALC_TYPE
#endif
#ifdef TO_CALC_TYPE_SAT
#undef TO_CALC_TYPE_SAT
#endif
#ifdef AS_CALC_TYPE
#undef AS_CALC_TYPE
#endif
#ifdef CALC_MAX_FUNC
#undef CALC_MAX_FUNC
#endif
#ifdef CALC_MIN_FUNC
#undef CALC_MIN_FUNC
#endif
#ifdef CALC_ABS_FUNC
#undef CALC_ABS_FUNC
#endif
#ifdef CALC_TYPE_SIZE
#undef CALC_TYPE_SIZE
#endif
#ifdef CALC_IS_FP
#undef CALC_IS_FP
#endif
#ifdef INPUT_REORDER_TYPE
#undef INPUT_REORDER_TYPE
#endif
#ifdef INPUT_REORDER_VAL_MAX
#undef INPUT_REORDER_VAL_MAX
#endif
#ifdef INPUT_REORDER_VAL_MIN
#undef INPUT_REORDER_VAL_MIN
#endif
#ifdef INPUT_REORDER_VAL_ONE
#undef INPUT_REORDER_VAL_ONE
#endif
#ifdef INPUT_REORDER_VAL_ZERO
#undef INPUT_REORDER_VAL_ZERO
#endif
#ifdef TO_INPUT_REORDER_TYPE
#undef TO_INPUT_REORDER_TYPE
#endif
#ifdef TO_INPUT_REORDER_TYPE_SAT
#undef TO_INPUT_REORDER_TYPE_SAT
#endif
#ifdef AS_INPUT_REORDER_TYPE
#undef AS_INPUT_REORDER_TYPE
#endif
#ifdef INPUT_REORDER_MAX_FUNC
#undef INPUT_REORDER_MAX_FUNC
#endif
#ifdef INPUT_REORDER_MIN_FUNC
#undef INPUT_REORDER_MIN_FUNC
#endif
#ifdef INPUT_REORDER_ABS_FUNC
#undef INPUT_REORDER_ABS_FUNC
#endif
#ifdef INPUT_REORDER_TYPE_SIZE
#undef INPUT_REORDER_TYPE_SIZE
#endif
#ifdef INPUT_REORDER_IS_FP
#undef INPUT_REORDER_IS_FP
#endif
#ifdef OUTPUT_REORDER_TYPE
#undef OUTPUT_REORDER_TYPE
#endif
#ifdef OUTPUT_REORDER_VAL_MAX
#undef OUTPUT_REORDER_VAL_MAX
#endif
#ifdef OUTPUT_REORDER_VAL_MIN
#undef OUTPUT_REORDER_VAL_MIN
#endif
#ifdef OUTPUT_REORDER_VAL_ONE
#undef OUTPUT_REORDER_VAL_ONE
#endif
#ifdef OUTPUT_REORDER_VAL_ZERO
#undef OUTPUT_REORDER_VAL_ZERO
#endif
#ifdef TO_OUTPUT_REORDER_TYPE
#undef TO_OUTPUT_REORDER_TYPE
#endif
#ifdef TO_OUTPUT_REORDER_TYPE_SAT
#undef TO_OUTPUT_REORDER_TYPE_SAT
#endif
#ifdef AS_OUTPUT_REORDER_TYPE
#undef AS_OUTPUT_REORDER_TYPE
#endif
#ifdef OUTPUT_REORDER_MAX_FUNC
#undef OUTPUT_REORDER_MAX_FUNC
#endif
#ifdef OUTPUT_REORDER_MIN_FUNC
#undef OUTPUT_REORDER_MIN_FUNC
#endif
#ifdef OUTPUT_REORDER_ABS_FUNC
#undef OUTPUT_REORDER_ABS_FUNC
#endif
#ifdef OUTPUT_REORDER_TYPE_SIZE
#undef OUTPUT_REORDER_TYPE_SIZE
#endif
#ifdef OUTPUT_REORDER_IS_FP
#undef OUTPUT_REORDER_IS_FP
#endif
#ifdef MEAN_OP
#undef MEAN_OP
#endif
#ifdef NL_M_TYPED
#undef NL_M_TYPED
#endif
#ifdef NL_N_TYPED
#undef NL_N_TYPED
#endif
#ifdef ACTIVATION_FUNC_TYPED_TYPE
#undef ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_MAX
#undef ACTIVATION_FUNC_TYPED_VAL_MAX
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_MIN
#undef ACTIVATION_FUNC_TYPED_VAL_MIN
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_ONE
#undef ACTIVATION_FUNC_TYPED_VAL_ONE
#endif
#ifdef ACTIVATION_FUNC_TYPED_VAL_ZERO
#undef ACTIVATION_FUNC_TYPED_VAL_ZERO
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_TYPE
#undef TO_ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef TO_ACTIVATION_FUNC_TYPED_TYPE_SAT
#undef TO_ACTIVATION_FUNC_TYPED_TYPE_SAT
#endif
#ifdef AS_ACTIVATION_FUNC_TYPED_TYPE
#undef AS_ACTIVATION_FUNC_TYPED_TYPE
#endif
#ifdef ACTIVATION_FUNC_TYPED_MAX_FUNC
#undef ACTIVATION_FUNC_TYPED_MAX_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_MIN_FUNC
#undef ACTIVATION_FUNC_TYPED_MIN_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_ABS_FUNC
#undef ACTIVATION_FUNC_TYPED_ABS_FUNC
#endif
#ifdef ACTIVATION_FUNC_TYPED_TYPE_SIZE
#undef ACTIVATION_FUNC_TYPED_TYPE_SIZE
#endif
#ifdef ACTIVATION_FUNC_TYPED_IS_FP
#undef ACTIVATION_FUNC_TYPED_IS_FP
#endif
#ifdef ACTIVATION_PARAMS_TYPED
#undef ACTIVATION_PARAMS_TYPED
#endif
#ifdef ACTIVATION_FUNC_TYPED
#undef ACTIVATION_FUNC_TYPED
#endif
#ifdef ACTIVATION_TYPED
#undef ACTIVATION_TYPED
#endif
#ifdef SUB_GROUP_SIZE
#undef SUB_GROUP_SIZE
#endif
#ifdef GWS_BATCH
#undef GWS_BATCH
#endif
#ifdef GWS_FEATURE
#undef GWS_FEATURE
#endif
#ifdef GWS_YX
#undef GWS_YX
#endif

/* Build Log:
3:4067:22: warning: use of logical '&&' with constant operand
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                     ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3:4067:22: note: use '&' for a bitwise operation
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                     ^~
                     &
3:4067:22: note: remove constant to silence this warning
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3:5653:22: warning: use of logical '&&' with constant operand
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                     ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3:5653:22: note: use '&' for a bitwise operation
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                     ^~
                     &
3:5653:22: note: remove constant to silence this warning
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3:7251:22: warning: use of logical '&&' with constant operand
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                     ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3:7251:22: note: use '&' for a bitwise operation
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                     ^~
                     &
3:7251:22: note: remove constant to silence this warning
 if (USE_BLOCK_WRITE && (TILE_OUT_F_NUM % (TILE_OFM * SIMD) == 0 || out_f + (TILE_OFM * SIMD) <= TILE_OUT_F_NUM)) {
                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*/
