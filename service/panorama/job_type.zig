pub const JobType = enum {
    ota,
    reboot,

    pub const json_field_names = .{
        .ota = "OTA",
        .reboot = "REBOOT",
    };
};
