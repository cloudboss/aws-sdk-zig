pub const MachineType = enum {
    general,
    nvme,

    pub const json_field_names = .{
        .general = "GENERAL",
        .nvme = "NVME",
    };
};
