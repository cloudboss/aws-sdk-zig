/// **[Default policies only]** Specifies a destination Region for cross-Region
/// copy actions.
pub const CrossRegionCopyTarget = struct {
    /// The target Region, for example `us-east-1`.
    target_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .target_region = "TargetRegion",
    };
};
