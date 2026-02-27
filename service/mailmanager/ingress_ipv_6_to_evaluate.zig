const IngressIpv6Attribute = @import("ingress_ipv_6_attribute.zig").IngressIpv6Attribute;

/// The structure for an IPv6 based condition matching on the incoming mail.
pub const IngressIpv6ToEvaluate = union(enum) {
    /// An enum type representing the allowed attribute types for an IPv6 condition.
    attribute: ?IngressIpv6Attribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
