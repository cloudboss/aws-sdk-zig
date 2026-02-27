pub const DeviceRememberedStatusType = enum {
    remembered,
    not_remembered,

    pub const json_field_names = .{
        .remembered = "REMEMBERED",
        .not_remembered = "NOT_REMEMBERED",
    };
};
