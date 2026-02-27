pub const DeliveryMediumType = enum {
    sms,
    email,

    pub const json_field_names = .{
        .sms = "SMS",
        .email = "EMAIL",
    };
};
