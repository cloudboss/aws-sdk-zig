/// Specifies the CloudWatch alarm specification to use in an instance refresh.
pub const AlarmSpecification = struct {
    /// The names of one or more CloudWatch alarms to monitor for the instance
    /// refresh. You can
    /// specify up to 10 alarms.
    alarms: ?[]const []const u8,
};
