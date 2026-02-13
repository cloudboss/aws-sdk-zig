/// A CloudWatch alarm you apply to an automation or command.
pub const Alarm = struct {
    /// The name of your CloudWatch alarm.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
