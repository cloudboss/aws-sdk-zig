/// Specify the MXF profile, also called shim, for this output. To automatically
/// select a profile according to your output video codec and resolution, leave
/// blank. For a list of codecs supported with each MXF profile, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/codecs-supported-with-each-mxf-profile.html. For more information about the automatic selection behavior, see https://docs.aws.amazon.com/mediaconvert/latest/ug/default-automatic-selection-of-mxf-profiles.html.
pub const MxfProfile = enum {
    d_10,
    xdcam,
    op1_a,
    xavc,
    xdcam_rdd9,

    pub const json_field_names = .{
        .d_10 = "D_10",
        .xdcam = "XDCAM",
        .op1_a = "OP1A",
        .xavc = "XAVC",
        .xdcam_rdd9 = "XDCAM_RDD9",
    };
};
