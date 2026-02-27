/// Specify the XAVC profile for this output. For more information, see the Sony
/// documentation at https://www.xavc-info.org/. Note that MediaConvert doesn't
/// support the interlaced video XAVC operating points for XAVC_HD_INTRA_CBG. To
/// create an interlaced XAVC output, choose the profile XAVC_HD.
pub const XavcProfile = enum {
    xavc_hd_intra_cbg,
    xavc_4_k_intra_cbg,
    xavc_4_k_intra_vbr,
    xavc_hd,
    xavc_4_k,

    pub const json_field_names = .{
        .xavc_hd_intra_cbg = "XAVC_HD_INTRA_CBG",
        .xavc_4_k_intra_cbg = "XAVC_4K_INTRA_CBG",
        .xavc_4_k_intra_vbr = "XAVC_4K_INTRA_VBR",
        .xavc_hd = "XAVC_HD",
        .xavc_4_k = "XAVC_4K",
    };
};
