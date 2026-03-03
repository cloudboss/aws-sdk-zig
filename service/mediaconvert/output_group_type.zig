const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hls_group_settings => "HLS_GROUP_SETTINGS",
            .dash_iso_group_settings => "DASH_ISO_GROUP_SETTINGS",
            .file_group_settings => "FILE_GROUP_SETTINGS",
            .ms_smooth_group_settings => "MS_SMOOTH_GROUP_SETTINGS",
            .cmaf_group_settings => "CMAF_GROUP_SETTINGS",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
