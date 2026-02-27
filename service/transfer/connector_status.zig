pub const ConnectorStatus = enum {
    active,
    errored,
    pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .errored = "ERRORED",
        .pending = "PENDING",
    };
};
