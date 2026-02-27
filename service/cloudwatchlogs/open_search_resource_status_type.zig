pub const OpenSearchResourceStatusType = enum {
    active,
    not_found,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .not_found = "NOT_FOUND",
        .@"error" = "ERROR",
    };
};
