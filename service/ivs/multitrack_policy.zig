pub const MultitrackPolicy = enum {
    allow,
    require,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .require = "REQUIRE",
    };
};
