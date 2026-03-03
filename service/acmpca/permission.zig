const ActionType = @import("action_type.zig").ActionType;

/// Permissions designate which private CA actions can be performed by an Amazon
/// Web Services service or entity. In order for ACM to automatically renew
/// private certificates, you must give the ACM service principal all available
/// permissions (`IssueCertificate`, `GetCertificate`, and `ListPermissions`).
/// Permissions can be assigned with the
/// [CreatePermission](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreatePermission.html) action, removed with the [DeletePermission](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeletePermission.html) action, and listed with the [ListPermissions](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListPermissions.html) action.
pub const Permission = struct {
    /// The private CA actions that can be performed by the designated Amazon Web
    /// Services service.
    actions: ?[]const ActionType = null,

    /// The Amazon Resource Number (ARN) of the private CA from which the permission
    /// was issued.
    certificate_authority_arn: ?[]const u8 = null,

    /// The time at which the permission was created.
    created_at: ?i64 = null,

    /// The name of the policy that is associated with the permission.
    policy: ?[]const u8 = null,

    /// The Amazon Web Services service or entity that holds the permission. At this
    /// time, the only valid principal is `acm.amazonaws.com`.
    principal: ?[]const u8 = null,

    /// The ID of the account that assigned the permission.
    source_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .created_at = "CreatedAt",
        .policy = "Policy",
        .principal = "Principal",
        .source_account = "SourceAccount",
    };
};
