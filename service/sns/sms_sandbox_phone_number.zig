const SMSSandboxPhoneNumberVerificationStatus = @import("sms_sandbox_phone_number_verification_status.zig").SMSSandboxPhoneNumberVerificationStatus;

/// A verified or pending destination phone number in the SMS sandbox.
///
/// When you start using Amazon SNS to send SMS messages, your Amazon Web
/// Services account is in the
/// *SMS sandbox*. The SMS sandbox provides a safe environment for
/// you to try Amazon SNS features without risking your reputation as an SMS
/// sender. While your
/// Amazon Web Services account is in the SMS sandbox, you can use all of the
/// features of Amazon SNS. However, you can send
/// SMS messages only to verified destination phone numbers. For more
/// information, including how to
/// move out of the sandbox to send messages without restrictions,
/// see [SMS
/// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html) in
/// the *Amazon SNS Developer Guide*.
pub const SMSSandboxPhoneNumber = struct {
    /// The destination phone number.
    phone_number: ?[]const u8 = null,

    /// The destination phone number's verification status.
    status: ?SMSSandboxPhoneNumberVerificationStatus = null,
};
