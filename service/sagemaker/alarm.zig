/// An Amazon CloudWatch alarm configured to monitor metrics on an endpoint.
pub const Alarm = struct {
    /// The name of a CloudWatch alarm in your account.
    alarm_name: ?[]const u8,

    pub const json_field_names = .{
        .alarm_name = "AlarmName",
    };
};
