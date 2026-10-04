const GrantConstraints = @import("grant_constraints.zig").GrantConstraints;
const GrantOperation = @import("grant_operation.zig").GrantOperation;

/// Contains information about a grant.
pub const GrantListEntry = struct {
    /// The constraints on the grant, such as encryption context pairs or a
    /// SourceArn,
    /// that restrict the subsequent operations the grant allows.
    constraints: ?GrantConstraints = null,

    /// The date and time when the grant was created.
    creation_date: ?i64 = null,

    /// The identity that gets the permissions in the grant.
    ///
    /// When a grant is created with the `GranteePrincipal` field, the `ListGrants`
    /// response usually contains the user or role designated as the grantee
    /// principal in the grant. However, if the grantee principal
    /// is an Amazon Web Services service, the `GranteePrincipal` field contains an
    /// Amazon Web Services [service
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#principal-services), which
    /// might correspond to several different grantee principals, such as an IAM
    /// user, IAM role, or Amazon Web Services account.
    grantee_principal: ?[]const u8 = null,

    /// The Amazon Web Services [service
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#principal-services) that gets the permissions in the grant.
    grantee_service_principal: ?[]const u8 = null,

    /// The unique identifier for the grant.
    grant_id: ?[]const u8 = null,

    /// The Amazon Web Services account under which the grant was issued.
    issuing_account: ?[]const u8 = null,

    /// The unique identifier for the KMS key to which the grant applies.
    key_id: ?[]const u8 = null,

    /// The friendly name that identifies the grant. If a name was provided in the
    /// CreateGrant request, that name is returned. Otherwise this value is null.
    name: ?[]const u8 = null,

    /// The list of operations permitted by the grant.
    operations: ?[]const GrantOperation = null,

    /// The principal that can retire the grant.
    retiring_principal: ?[]const u8 = null,

    /// The Amazon Web Services [service
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#principal-services) that can retire the grant.
    retiring_service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .creation_date = "CreationDate",
        .grantee_principal = "GranteePrincipal",
        .grantee_service_principal = "GranteeServicePrincipal",
        .grant_id = "GrantId",
        .issuing_account = "IssuingAccount",
        .key_id = "KeyId",
        .name = "Name",
        .operations = "Operations",
        .retiring_principal = "RetiringPrincipal",
        .retiring_service_principal = "RetiringServicePrincipal",
    };
};
