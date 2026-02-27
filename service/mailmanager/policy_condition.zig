const IngressBooleanExpression = @import("ingress_boolean_expression.zig").IngressBooleanExpression;
const IngressIpv4Expression = @import("ingress_ipv_4_expression.zig").IngressIpv4Expression;
const IngressIpv6Expression = @import("ingress_ipv_6_expression.zig").IngressIpv6Expression;
const IngressStringExpression = @import("ingress_string_expression.zig").IngressStringExpression;
const IngressTlsProtocolExpression = @import("ingress_tls_protocol_expression.zig").IngressTlsProtocolExpression;

/// The email traffic filtering conditions which are contained in a traffic
/// policy resource.
pub const PolicyCondition = union(enum) {
    /// This represents a boolean type condition matching on the incoming mail. It
    /// performs the boolean operation configured in 'Operator' and evaluates the
    /// 'Protocol' object against the 'Value'.
    boolean_expression: ?IngressBooleanExpression,
    /// This represents an IP based condition matching on the incoming mail. It
    /// performs the operation configured in 'Operator' and evaluates the 'Protocol'
    /// object against the 'Value'.
    ip_expression: ?IngressIpv4Expression,
    /// This represents an IPv6 based condition matching on the incoming mail. It
    /// performs the operation configured in 'Operator' and evaluates the 'Protocol'
    /// object against the 'Value'.
    ipv_6_expression: ?IngressIpv6Expression,
    /// This represents a string based condition matching on the incoming mail. It
    /// performs the string operation configured in 'Operator' and evaluates the
    /// 'Protocol' object against the 'Value'.
    string_expression: ?IngressStringExpression,
    /// This represents a TLS based condition matching on the incoming mail. It
    /// performs the operation configured in 'Operator' and evaluates the 'Protocol'
    /// object against the 'Value'.
    tls_expression: ?IngressTlsProtocolExpression,

    pub const json_field_names = .{
        .boolean_expression = "BooleanExpression",
        .ip_expression = "IpExpression",
        .ipv_6_expression = "Ipv6Expression",
        .string_expression = "StringExpression",
        .tls_expression = "TlsExpression",
    };
};
