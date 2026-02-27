pub const PackageVersionAction = enum {
    publish,
    deprecate,

    pub const json_field_names = .{
        .publish = "PUBLISH",
        .deprecate = "DEPRECATE",
    };
};
