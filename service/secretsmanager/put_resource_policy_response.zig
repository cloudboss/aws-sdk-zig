pub const PutResourcePolicyResponse = struct {
    /// The ARN of the secret.
    arn: ?[]const u8,

    /// The name of the secret.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
    };
};
