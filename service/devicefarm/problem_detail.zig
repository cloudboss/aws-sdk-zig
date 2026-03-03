/// Information about a problem detail.
pub const ProblemDetail = struct {
    /// The problem detail's ARN.
    arn: ?[]const u8 = null,

    /// The problem detail's name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
