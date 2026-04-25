const Analysis = @import("analysis.zig").Analysis;
const RuleStringEmailAttribute = @import("rule_string_email_attribute.zig").RuleStringEmailAttribute;
const RuleClientCertificateAttribute = @import("rule_client_certificate_attribute.zig").RuleClientCertificateAttribute;

/// The string to evaluate in a string condition expression.
pub const RuleStringToEvaluate = union(enum) {
    /// The Add On ARN and its returned value to evaluate in a string condition
    /// expression.
    analysis: ?Analysis,
    /// The email attribute to evaluate in a string condition expression.
    attribute: ?RuleStringEmailAttribute,
    /// The client certificate attribute to evaluate in a string condition
    /// expression.
    client_certificate_attribute: ?RuleClientCertificateAttribute,
    /// The email MIME X-Header attribute to evaluate in a string condition
    /// expression.
    mime_header_attribute: ?[]const u8,

    pub const json_field_names = .{
        .analysis = "Analysis",
        .attribute = "Attribute",
        .client_certificate_attribute = "ClientCertificateAttribute",
        .mime_header_attribute = "MimeHeaderAttribute",
    };
};
