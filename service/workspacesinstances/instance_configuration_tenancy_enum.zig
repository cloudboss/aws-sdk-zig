pub const InstanceConfigurationTenancyEnum = enum {
    shared,
    dedicated,

    pub const json_field_names = .{
        .shared = "SHARED",
        .dedicated = "DEDICATED",
    };
};
