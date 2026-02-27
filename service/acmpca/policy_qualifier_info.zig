const PolicyQualifierId = @import("policy_qualifier_id.zig").PolicyQualifierId;
const Qualifier = @import("qualifier.zig").Qualifier;

/// Modifies the `CertPolicyId` of a `PolicyInformation` object with a
/// qualifier. Amazon Web Services Private CA supports the certification
/// practice statement (CPS) qualifier.
pub const PolicyQualifierInfo = struct {
    /// Identifies the qualifier modifying a `CertPolicyId`.
    policy_qualifier_id: PolicyQualifierId,

    /// Defines the qualifier type. Amazon Web Services Private CA supports the use
    /// of a URI for a CPS qualifier in this field.
    qualifier: Qualifier,

    pub const json_field_names = .{
        .policy_qualifier_id = "PolicyQualifierId",
        .qualifier = "Qualifier",
    };
};
