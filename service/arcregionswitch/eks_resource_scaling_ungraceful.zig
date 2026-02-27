/// The ungraceful settings for Amazon Web Services EKS resource scaling.
pub const EksResourceScalingUngraceful = struct {
    /// The minimum success percentage for the configuration.
    minimum_success_percentage: i32,

    pub const json_field_names = .{
        .minimum_success_percentage = "minimumSuccessPercentage",
    };
};
