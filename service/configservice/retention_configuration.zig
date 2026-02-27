/// An object with the name of the retention configuration and the retention
/// period in days. The object stores the configuration for data retention in
/// Config.
pub const RetentionConfiguration = struct {
    /// The name of the retention configuration object.
    name: []const u8,

    /// Number of days Config stores your historical information.
    ///
    /// Currently, only applicable to the configuration item history.
    retention_period_in_days: i32,

    pub const json_field_names = .{
        .name = "Name",
        .retention_period_in_days = "RetentionPeriodInDays",
    };
};
