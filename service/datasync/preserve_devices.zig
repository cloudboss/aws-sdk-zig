pub const PreserveDevices = enum {
    none,
    preserve,

    pub const json_field_names = .{
        .none = "NONE",
        .preserve = "PRESERVE",
    };
};
