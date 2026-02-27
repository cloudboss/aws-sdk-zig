pub const PublicBucketRestrictBehavior = enum {
    restricted,
    not_restricted,

    pub const json_field_names = .{
        .restricted = "RESTRICTED",
        .not_restricted = "NOT_RESTRICTED",
    };
};
