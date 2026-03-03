/// High-level information about a proxy rule group, returned by operations like
/// create and
/// describe. You can use the information provided in the metadata to retrieve
/// and manage a
/// proxy rule group. You can retrieve all objects for a proxy rule group by
/// calling DescribeProxyRuleGroup.
pub const ProxyRuleGroupMetadata = struct {
    /// The Amazon Resource Name (ARN) of a proxy rule group.
    arn: ?[]const u8 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
