const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;
const SuppressionListScope = @import("suppression_list_scope.zig").SuppressionListScope;
const SuppressionValidationOptions = @import("suppression_validation_options.zig").SuppressionValidationOptions;

/// An object that contains information about the suppression list preferences
/// for your
/// account or for a specific tenant.
pub const SuppressionOptions = struct {
    /// A list that contains the reasons that email addresses are automatically
    /// added to the
    /// suppression list for your account or for a specific tenant. This list can
    /// contain any or all of the
    /// following:
    ///
    /// * `COMPLAINT` – Amazon SES adds an email address to the suppression
    /// list for your account or for a specific tenant when a message sent to that
    /// address results in a
    /// complaint.
    ///
    /// * `BOUNCE` – Amazon SES adds an email address to the suppression
    /// list for your account or for a specific tenant when a message sent to that
    /// address results in a hard
    /// bounce.
    suppressed_reasons: ?[]const SuppressionListReason = null,

    /// The suppression scope for the configuration set. This overrides the tenant
    /// or account
    /// suppression scope for emails sent using this configuration set. Can be one
    /// of the
    /// following:
    ///
    /// * `TENANT` – Use the tenant's suppression list.
    ///
    /// * `ACCOUNT` – Use the account-level suppression list.
    suppression_scope: ?SuppressionListScope = null,

    validation_options: ?SuppressionValidationOptions = null,

    pub const json_field_names = .{
        .suppressed_reasons = "SuppressedReasons",
        .suppression_scope = "SuppressionScope",
        .validation_options = "ValidationOptions",
    };
};
