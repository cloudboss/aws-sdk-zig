const CertificateField = @import("certificate_field.zig").CertificateField;
const MappingRule = @import("mapping_rule.zig").MappingRule;

/// A mapping applied to the authenticating end-entity certificate.
pub const AttributeMapping = struct {
    /// Fields (x509Subject, x509Issuer and x509SAN) within X.509 certificates.
    certificate_field: ?CertificateField = null,

    /// A list of mapping entries for every supported specifier or sub-field.
    mapping_rules: ?[]const MappingRule = null,

    pub const json_field_names = .{
        .certificate_field = "certificateField",
        .mapping_rules = "mappingRules",
    };
};
