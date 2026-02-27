const IngressIpv4Attribute = @import("ingress_ipv_4_attribute.zig").IngressIpv4Attribute;

/// The structure for an IP based condition matching on the incoming mail.
pub const IngressIpToEvaluate = union(enum) {
    /// An enum type representing the allowed attribute types for an IP condition.
    attribute: ?IngressIpv4Attribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
