/// Setting for HDR10+ metadata insertion
pub const Hdr10Plus = struct {
    /// Specify the HDR10+ mastering display normalized peak luminance, in nits.
    /// This is the normalized actual peak luminance of the mastering display, as
    /// defined by ST 2094-40.
    mastering_monitor_nits: ?i32,

    /// Specify the HDR10+ target display nominal peak luminance, in nits. This is
    /// the nominal maximum luminance of the target display as defined by ST
    /// 2094-40.
    target_monitor_nits: ?i32,

    pub const json_field_names = .{
        .mastering_monitor_nits = "MasteringMonitorNits",
        .target_monitor_nits = "TargetMonitorNits",
    };
};
