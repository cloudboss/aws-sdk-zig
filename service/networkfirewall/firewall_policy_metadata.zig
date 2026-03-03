/// High-level information about a firewall policy, returned by operations like
/// create and
/// describe. You can use the information provided in the metadata to retrieve
/// and manage a
/// firewall policy. You can retrieve all objects for a firewall policy by
/// calling DescribeFirewallPolicy.
pub const FirewallPolicyMetadata = struct {
    /// The Amazon Resource Name (ARN) of the firewall policy.
    arn: ?[]const u8 = null,

    /// The descriptive name of the firewall policy. You can't change the name of a
    /// firewall policy after you create it.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
