pub const DeviceType = enum {
    qpu,
    simulator,

    pub const json_field_names = .{
        .qpu = "QPU",
        .simulator = "SIMULATOR",
    };
};
