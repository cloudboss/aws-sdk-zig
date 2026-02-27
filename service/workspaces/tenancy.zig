pub const Tenancy = enum {
    dedicated,
    shared,

    pub const json_field_names = .{
        .dedicated = "DEDICATED",
        .shared = "SHARED",
    };
};
