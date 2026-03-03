/// Describes which features are activated for the detector.
pub const AwsGuardDutyDetectorFeaturesDetails = struct {
    /// Indicates the name of the feature that is activated for the detector.
    name: ?[]const u8 = null,

    /// Indicates the status of the feature that is activated for the detector.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
    };
};
