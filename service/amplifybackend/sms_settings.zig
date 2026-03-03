/// SMS settings for authentication.
pub const SmsSettings = struct {
    /// The contents of the SMS message.
    sms_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .sms_message = "SmsMessage",
    };
};
