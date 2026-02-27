pub const PushNotificationType = enum {
    default,
    voip,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .voip = "VOIP",
    };
};
