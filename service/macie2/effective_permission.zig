pub const EffectivePermission = enum {
    public,
    not_public,
    unknown,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .not_public = "NOT_PUBLIC",
        .unknown = "UNKNOWN",
    };
};
