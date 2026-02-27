pub const DeviceFormFactor = enum {
    phone,
    tablet,

    pub const json_field_names = .{
        .phone = "PHONE",
        .tablet = "TABLET",
    };
};
