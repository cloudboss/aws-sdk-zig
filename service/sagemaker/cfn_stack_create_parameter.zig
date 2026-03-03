/// A key-value pair that represents a parameter for the CloudFormation stack.
pub const CfnStackCreateParameter = struct {
    /// The name of the CloudFormation parameter.
    key: []const u8,

    /// The value of the CloudFormation parameter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
