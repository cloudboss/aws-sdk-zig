pub const ChangeType = enum {
    immediate,
    requires_reboot,

    pub const json_field_names = .{
        .immediate = "IMMEDIATE",
        .requires_reboot = "REQUIRES_REBOOT",
    };
};
