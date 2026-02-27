const IngressTlsAttribute = @import("ingress_tls_attribute.zig").IngressTlsAttribute;

/// The union type representing the allowed types for the left hand side of a
/// TLS condition.
pub const IngressTlsProtocolToEvaluate = union(enum) {
    /// The enum type representing the allowed attribute types for the TLS
    /// condition.
    attribute: ?IngressTlsAttribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
