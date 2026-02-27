const IngressTlsProtocolToEvaluate = @import("ingress_tls_protocol_to_evaluate.zig").IngressTlsProtocolToEvaluate;
const IngressTlsProtocolOperator = @import("ingress_tls_protocol_operator.zig").IngressTlsProtocolOperator;
const IngressTlsProtocolAttribute = @import("ingress_tls_protocol_attribute.zig").IngressTlsProtocolAttribute;

/// The structure for a TLS related condition matching on the incoming mail.
pub const IngressTlsProtocolExpression = struct {
    /// The left hand side argument of a TLS condition expression.
    evaluate: IngressTlsProtocolToEvaluate,

    /// The matching operator for a TLS condition expression.
    operator: IngressTlsProtocolOperator,

    /// The right hand side argument of a TLS condition expression.
    value: IngressTlsProtocolAttribute,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .value = "Value",
    };
};
