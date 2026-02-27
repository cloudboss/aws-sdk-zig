pub const OutdatedInstancesStrategy = enum {
    update,
    ignore,

    pub const json_field_names = .{
        .update = "Update",
        .ignore = "Ignore",
    };
};
