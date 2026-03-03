/// Contains information about an Amazon Inspector rules package. This data type
/// is used
/// as the response element in the DescribeRulesPackages action.
pub const RulesPackage = struct {
    /// The ARN of the rules package.
    arn: []const u8,

    /// The description of the rules package.
    description: ?[]const u8 = null,

    /// The name of the rules package.
    name: []const u8,

    /// The provider of the rules package.
    provider: []const u8,

    /// The version ID of the rules package.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .name = "name",
        .provider = "provider",
        .version = "version",
    };
};
