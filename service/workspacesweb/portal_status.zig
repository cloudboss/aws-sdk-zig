pub const PortalStatus = enum {
    incomplete,
    pending,
    active,

    pub const json_field_names = .{
        .incomplete = "INCOMPLETE",
        .pending = "PENDING",
        .active = "ACTIVE",
    };
};
