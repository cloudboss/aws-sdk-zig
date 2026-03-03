const aws = @import("aws");

const Configuration = @import("configuration.zig").Configuration;
const PortRange = @import("port_range.zig").PortRange;

/// A configuration for Amazon EMR block public access. When
/// `BlockPublicSecurityGroupRules` is set to `true`, Amazon EMR prevents
/// cluster creation if one of the cluster's security groups has a rule that
/// allows
/// inbound traffic from 0.0.0.0/0 or ::/0 on a port, unless the port is
/// specified as an
/// exception using `PermittedPublicSecurityGroupRuleRanges`.
pub const BlockPublicAccessConfiguration = struct {
    /// Indicates whether Amazon EMR block public access is enabled (`true`)
    /// or disabled (`false`). By default, the value is `false` for accounts
    /// that have created Amazon EMR clusters before July 2019. For accounts created
    /// after
    /// this, the default is `true`.
    block_public_security_group_rules: bool,

    /// The classification within a configuration.
    classification: ?[]const u8 = null,

    /// A list of additional configurations to apply within a configuration object.
    configurations: ?[]const Configuration = null,

    /// Specifies ports and port ranges that are permitted to have security group
    /// rules that
    /// allow inbound traffic from all public sources. For example, if Port 23
    /// (Telnet) is
    /// specified for `PermittedPublicSecurityGroupRuleRanges`, Amazon EMR
    /// allows cluster creation if a security group associated with the cluster has
    /// a rule that
    /// allows inbound traffic on Port 23 from IPv4 0.0.0.0/0 or IPv6 port ::/0 as
    /// the
    /// source.
    ///
    /// By default, Port 22, which is used for SSH access to the cluster Amazon EC2
    /// instances, is in the list of `PermittedPublicSecurityGroupRuleRanges`.
    permitted_public_security_group_rule_ranges: ?[]const PortRange = null,

    /// A set of properties specified within a configuration classification.
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .block_public_security_group_rules = "BlockPublicSecurityGroupRules",
        .classification = "Classification",
        .configurations = "Configurations",
        .permitted_public_security_group_rule_ranges = "PermittedPublicSecurityGroupRuleRanges",
        .properties = "Properties",
    };
};
