pub const GetResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the Lambda resource you want to retrieve
    /// the policy for. You can use a qualified or an unqualified ARN. The value
    /// must be a complete ARN, and the operation does not accept wildcard
    /// characters.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
