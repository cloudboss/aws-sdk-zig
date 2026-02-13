pub const RebootOption = enum {
    reboot_if_needed,
    no_reboot,

    pub const json_field_names = .{
        .reboot_if_needed = "REBOOT_IF_NEEDED",
        .no_reboot = "NO_REBOOT",
    };
};
