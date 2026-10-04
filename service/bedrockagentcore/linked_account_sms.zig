/// Linked account using a phone number in E.164 format.
pub const LinkedAccountSms = struct {
    /// The phone number in E.164 format (e.g., +1234567890).
    phone_number: []const u8,

    pub const json_field_names = .{
        .phone_number = "phoneNumber",
    };
};
