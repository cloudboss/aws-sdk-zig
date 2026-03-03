const MsSmoothH265PackagingType = @import("ms_smooth_h265_packaging_type.zig").MsSmoothH265PackagingType;

/// Ms Smooth Output Settings
pub const MsSmoothOutputSettings = struct {
    /// Only applicable when this output is referencing an H.265 video description.
    /// Specifies whether MP4 segments should be packaged as HEV1 or HVC1.
    h265_packaging_type: ?MsSmoothH265PackagingType = null,

    /// String concatenated to the end of the destination filename. Required for
    /// multiple outputs of the same type.
    name_modifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .h265_packaging_type = "H265PackagingType",
        .name_modifier = "NameModifier",
    };
};
