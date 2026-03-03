const BulkEmailStatus = @import("bulk_email_status.zig").BulkEmailStatus;

/// The result of the `SendBulkEmail` operation of each specified
/// `BulkEmailEntry`.
pub const BulkEmailEntryResult = struct {
    /// A description of an error that prevented a message being sent using the
    /// `SendBulkTemplatedEmail` operation.
    @"error": ?[]const u8 = null,

    /// The unique message identifier returned from the `SendBulkTemplatedEmail`
    /// operation.
    message_id: ?[]const u8 = null,

    /// The status of a message sent using the `SendBulkTemplatedEmail`
    /// operation.
    ///
    /// Possible values for this parameter include:
    ///
    /// * SUCCESS: Amazon SES accepted the message, and will attempt to deliver it
    ///   to
    /// the recipients.
    ///
    /// * MESSAGE_REJECTED: The message was rejected because it contained a
    /// virus.
    ///
    /// * MAIL_FROM_DOMAIN_NOT_VERIFIED: The sender's email address or domain was
    ///   not
    /// verified.
    ///
    /// * CONFIGURATION_SET_DOES_NOT_EXIST: The configuration set you specified does
    ///   not
    /// exist.
    ///
    /// * TEMPLATE_DOES_NOT_EXIST: The template you specified does not exist.
    ///
    /// * ACCOUNT_SUSPENDED: Your account has been shut down because of issues
    ///   related
    /// to your email sending practices.
    ///
    /// * ACCOUNT_THROTTLED: The number of emails you can send has been reduced
    ///   because
    /// your account has exceeded its allocated sending limit.
    ///
    /// * ACCOUNT_DAILY_QUOTA_EXCEEDED: You have reached or exceeded the maximum
    ///   number
    /// of emails you can send from your account in a 24-hour period.
    ///
    /// * INVALID_SENDING_POOL_NAME: The configuration set you specified refers to
    ///   an IP
    /// pool that does not exist.
    ///
    /// * ACCOUNT_SENDING_PAUSED: Email sending for the Amazon SES account was
    ///   disabled
    /// using the
    /// [UpdateAccountSendingEnabled](https://docs.aws.amazon.com/ses/latest/APIReference/API_UpdateAccountSendingEnabled.html) operation.
    ///
    /// * CONFIGURATION_SET_SENDING_PAUSED: Email sending for this configuration set
    ///   was
    /// disabled using the
    /// [UpdateConfigurationSetSendingEnabled](https://docs.aws.amazon.com/ses/latest/APIReference/API_UpdateConfigurationSetSendingEnabled.html) operation.
    ///
    /// * INVALID_PARAMETER_VALUE: One or more of the parameters you specified when
    /// calling this operation was invalid. See the error message for additional
    /// information.
    ///
    /// * TRANSIENT_FAILURE: Amazon SES was unable to process your request because
    ///   of a
    /// temporary issue.
    ///
    /// * FAILED: Amazon SES was unable to process your request. See the error
    ///   message
    /// for additional information.
    status: ?BulkEmailStatus = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .message_id = "MessageId",
        .status = "Status",
    };
};
