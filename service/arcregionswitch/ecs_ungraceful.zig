/// The settings for ungraceful execution.
pub const EcsUngraceful = struct {
    /// The minimum success percentage specified for the configuration.
    minimum_success_percentage: i32,

    pub const json_field_names = .{
        .minimum_success_percentage = "minimumSuccessPercentage",
    };
};
