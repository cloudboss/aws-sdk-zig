const MxfXavcDurationMode = @import("mxf_xavc_duration_mode.zig").MxfXavcDurationMode;

/// Specify the XAVC profile settings for MXF outputs when you set your MXF
/// profile to XAVC.
pub const MxfXavcProfileSettings = struct {
    /// To create an output that complies with the XAVC file format guidelines for
    /// interoperability, keep the default value, Drop frames for compliance. To
    /// include all frames from your input in this output, keep the default setting,
    /// Allow any duration. The number of frames that MediaConvert excludes when you
    /// set this to Drop frames for compliance depends on the output frame rate and
    /// duration.
    duration_mode: ?MxfXavcDurationMode,

    /// Specify a value for this setting only for outputs that you set up with one
    /// of these two XAVC profiles: XAVC HD Intra CBG or XAVC 4K Intra CBG. Specify
    /// the amount of space in each frame that the service reserves for ancillary
    /// data, such as teletext captions. The default value for this setting is 1492
    /// bytes per frame. This should be sufficient to prevent overflow unless you
    /// have multiple pages of teletext captions data. If you have a large amount of
    /// teletext data, specify a larger number.
    max_anc_data_size: ?i32,

    pub const json_field_names = .{
        .duration_mode = "DurationMode",
        .max_anc_data_size = "MaxAncDataSize",
    };
};
