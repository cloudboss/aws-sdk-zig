const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;
const SuppressionListScope = @import("suppression_list_scope.zig").SuppressionListScope;

/// An object that contains the suppression list preferences for a tenant.
pub const TenantSuppressionAttributes = struct {
    /// A list that contains the reasons that email addresses are automatically
    /// added to the
    /// suppression list for the tenant. This list can contain any or all of the
    /// following:
    ///
    /// * `COMPLAINT` – Amazon SES adds an email address to the suppression
    /// list when a message sent to that address results in a complaint.
    ///
    /// * `BOUNCE` – Amazon SES adds an email address to the suppression
    /// list when a message sent to that address results in a hard bounce.
    suppressed_reasons: ?[]const SuppressionListReason = null,

    /// The suppression scope for the tenant. Can be one of the following:
    ///
    /// * `TENANT` – The tenant uses its own suppression list.
    ///
    /// * `ACCOUNT` – The tenant uses the account-level suppression list.
    ///
    /// If you don't specify a suppression scope, the tenant defaults to `ACCOUNT`
    /// scope
    /// and uses the account-level suppression list.
    suppression_scope: ?SuppressionListScope = null,

    pub const json_field_names = .{
        .suppressed_reasons = "SuppressedReasons",
        .suppression_scope = "SuppressionScope",
    };
};
