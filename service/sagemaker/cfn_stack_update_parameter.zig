/// A key-value pair representing a parameter used in the CloudFormation stack.
pub const CfnStackUpdateParameter = struct {
    /// The name of the CloudFormation parameter.
    key: []const u8,

    /// The value of the CloudFormation parameter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
