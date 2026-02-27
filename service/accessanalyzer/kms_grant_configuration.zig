const KmsGrantConstraints = @import("kms_grant_constraints.zig").KmsGrantConstraints;
const KmsGrantOperation = @import("kms_grant_operation.zig").KmsGrantOperation;

/// A proposed grant configuration for a KMS key. For more information, see
/// [CreateGrant](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateGrant.html).
pub const KmsGrantConfiguration = struct {
    /// Use this structure to propose allowing [cryptographic
    /// operations](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#cryptographic-operations) in the grant only when the operation request includes the specified [encryption context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context).
    constraints: ?KmsGrantConstraints,

    /// The principal that is given permission to perform the operations that the
    /// grant permits.
    grantee_principal: []const u8,

    /// The Amazon Web Services account under which the grant was issued. The
    /// account is used to propose KMS grants issued by accounts other than the
    /// owner of the key.
    issuing_account: []const u8,

    /// A list of operations that the grant permits.
    operations: []const KmsGrantOperation,

    /// The principal that is given permission to retire the grant by using
    /// [RetireGrant](https://docs.aws.amazon.com/kms/latest/APIReference/API_RetireGrant.html) operation.
    retiring_principal: ?[]const u8,

    pub const json_field_names = .{
        .constraints = "constraints",
        .grantee_principal = "granteePrincipal",
        .issuing_account = "issuingAccount",
        .operations = "operations",
        .retiring_principal = "retiringPrincipal",
    };
};
