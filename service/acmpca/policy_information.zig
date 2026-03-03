const PolicyQualifierInfo = @import("policy_qualifier_info.zig").PolicyQualifierInfo;

/// Defines the X.509 `CertificatePolicies` extension.
pub const PolicyInformation = struct {
    /// Specifies the object identifier (OID) of the certificate policy under which
    /// the certificate was issued. For more information, see NIST's definition of
    /// [Object Identifier
    /// (OID)](https://csrc.nist.gov/glossary/term/Object_Identifier).
    cert_policy_id: []const u8,

    /// Modifies the given `CertPolicyId` with a qualifier. Amazon Web Services
    /// Private CA supports the certification practice statement (CPS) qualifier.
    policy_qualifiers: ?[]const PolicyQualifierInfo = null,

    pub const json_field_names = .{
        .cert_policy_id = "CertPolicyId",
        .policy_qualifiers = "PolicyQualifiers",
    };
};
