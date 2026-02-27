pub const PackageGroupOriginRestrictionType = enum {
    external_upstream,
    internal_upstream,
    publish,

    pub const json_field_names = .{
        .external_upstream = "EXTERNAL_UPSTREAM",
        .internal_upstream = "INTERNAL_UPSTREAM",
        .publish = "PUBLISH",
    };
};
