/// Contains information about a phone number for a quick connect.
pub const PhoneNumberQuickConnectConfig = struct {
    /// The phone number in E.164 format.
    phone_number: []const u8,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
    };
};
