pub const MasterNodeStatus = enum {
    available,
    un_available,

    pub const json_field_names = .{
        .available = "Available",
        .un_available = "UnAvailable",
    };
};
