/// Type of output group (File group, Apple HLS, DASH ISO, Microsoft Smooth
/// Streaming, CMAF)
pub const OutputGroupType = enum {
    hls_group_settings,
    dash_iso_group_settings,
    file_group_settings,
    ms_smooth_group_settings,
    cmaf_group_settings,

    pub const json_field_names = .{
        .hls_group_settings = "HLS_GROUP_SETTINGS",
        .dash_iso_group_settings = "DASH_ISO_GROUP_SETTINGS",
        .file_group_settings = "FILE_GROUP_SETTINGS",
        .ms_smooth_group_settings = "MS_SMOOTH_GROUP_SETTINGS",
        .cmaf_group_settings = "CMAF_GROUP_SETTINGS",
    };
};
