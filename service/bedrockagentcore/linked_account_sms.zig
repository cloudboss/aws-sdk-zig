/// LinkedAccount using a phone number in E.164 format.
pub const LinkedAccountSms = struct {
    /// The phone number in E.164 format (e.g., +1234567890).
    /// Must be a valid E.164 formatted phone number starting with + and containing
    /// 1-15 digits.
    phone_number: []const u8,

    pub const json_field_names = .{
        .phone_number = "phoneNumber",
    };
};
