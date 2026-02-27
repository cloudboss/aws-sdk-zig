pub const RepairAction = enum {
    replace,
    reboot,
    no_action,

    pub const json_field_names = .{
        .replace = "Replace",
        .reboot = "Reboot",
        .no_action = "NoAction",
    };
};
