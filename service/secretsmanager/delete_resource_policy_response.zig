pub const DeleteResourcePolicyResponse = struct {
    /// The ARN of the secret that the resource-based policy was deleted for.
    arn: ?[]const u8 = null,

    /// The name of the secret that the resource-based policy was deleted for.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
    };
};
