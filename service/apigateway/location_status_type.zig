pub const LocationStatusType = enum {
    documented,
    undocumented,

    pub const json_field_names = .{
        .documented = "DOCUMENTED",
        .undocumented = "UNDOCUMENTED",
    };
};
