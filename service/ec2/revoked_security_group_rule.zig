/// A security group rule removed with
/// [RevokeSecurityGroupEgress](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RevokeSecurityGroupEgress.html) or [RevokeSecurityGroupIngress](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RevokeSecurityGroupIngress.html).
pub const RevokedSecurityGroupRule = struct {
    /// The IPv4 CIDR of the traffic source.
    cidr_ipv_4: ?[]const u8 = null,

    /// The IPv6 CIDR of the traffic source.
    cidr_ipv_6: ?[]const u8 = null,

    /// A description of the revoked security group rule.
    description: ?[]const u8 = null,

    /// The 'from' port number of the security group rule.
    from_port: ?i32 = null,

    /// A security group ID.
    group_id: ?[]const u8 = null,

    /// The security group rule's protocol.
    ip_protocol: ?[]const u8 = null,

    /// Defines if a security group rule is an outbound rule.
    is_egress: ?bool = null,

    /// The ID of a prefix list that's the traffic source.
    prefix_list_id: ?[]const u8 = null,

    /// The ID of a referenced security group.
    referenced_group_id: ?[]const u8 = null,

    /// A security group rule ID.
    security_group_rule_id: ?[]const u8 = null,

    /// The 'to' port number of the security group rule.
    to_port: ?i32 = null,
};
