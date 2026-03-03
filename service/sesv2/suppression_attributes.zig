const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;
const SuppressionValidationAttributes = @import("suppression_validation_attributes.zig").SuppressionValidationAttributes;

/// An object that contains information about the email address suppression
/// preferences
/// for your account in the current Amazon Web Services Region.
pub const SuppressionAttributes = struct {
    /// A list that contains the reasons that email addresses will be automatically
    /// added to
    /// the suppression list for your account. This list can contain any or all of
    /// the
    /// following:
    ///
    /// * `COMPLAINT` – Amazon SES adds an email address to the suppression
    /// list for your account when a message sent to that address results in a
    /// complaint.
    ///
    /// * `BOUNCE` – Amazon SES adds an email address to the suppression
    /// list for your account when a message sent to that address results in a hard
    /// bounce.
    suppressed_reasons: ?[]const SuppressionListReason = null,

    validation_attributes: ?SuppressionValidationAttributes = null,

    pub const json_field_names = .{
        .suppressed_reasons = "SuppressedReasons",
        .validation_attributes = "ValidationAttributes",
    };
};
