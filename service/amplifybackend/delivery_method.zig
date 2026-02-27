/// The type of verification message to send.
pub const DeliveryMethod = enum {
    email,
    sms,

    pub const json_field_names = .{
        .email = "EMAIL",
        .sms = "SMS",
    };
};
