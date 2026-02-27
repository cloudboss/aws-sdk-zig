const GrantConstraints = @import("grant_constraints.zig").GrantConstraints;
const GrantOperation = @import("grant_operation.zig").GrantOperation;

/// Contains information about a grant.
pub const GrantListEntry = struct {
    /// A list of key-value pairs that must be present in the encryption context of
    /// certain
    /// subsequent operations that the grant allows.
    constraints: ?GrantConstraints,

    /// The date and time when the grant was created.
    creation_date: ?i64,

    /// The identity that gets the permissions in the grant.
    ///
    /// The `GranteePrincipal` field in the `ListGrants` response usually contains
    /// the
    /// user or role designated as the grantee principal in the grant. However, when
    /// the grantee
    /// principal in the grant is an Amazon Web Services service, the
    /// `GranteePrincipal` field contains
    /// the [service
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#principal-services), which might represent several different grantee principals.
    grantee_principal: ?[]const u8,

    /// The unique identifier for the grant.
    grant_id: ?[]const u8,

    /// The Amazon Web Services account under which the grant was issued.
    issuing_account: ?[]const u8,

    /// The unique identifier for the KMS key to which the grant applies.
    key_id: ?[]const u8,

    /// The friendly name that identifies the grant. If a name was provided in the
    /// CreateGrant request, that name is returned. Otherwise this value is null.
    name: ?[]const u8,

    /// The list of operations permitted by the grant.
    operations: ?[]const GrantOperation,

    /// The principal that can retire the grant.
    retiring_principal: ?[]const u8,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .creation_date = "CreationDate",
        .grantee_principal = "GranteePrincipal",
        .grant_id = "GrantId",
        .issuing_account = "IssuingAccount",
        .key_id = "KeyId",
        .name = "Name",
        .operations = "Operations",
        .retiring_principal = "RetiringPrincipal",
    };
};
