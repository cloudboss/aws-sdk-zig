/// A target to which an alert is sent when a security profile behavior is
/// violated.
pub const SecurityProfileTarget = struct {
    /// The ARN of the security profile.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
