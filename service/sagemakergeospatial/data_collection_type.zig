pub const DataCollectionType = enum {
    /// PUBLIC
    public,
    /// PREMIUM
    premium,
    /// USER
    user,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .premium = "PREMIUM",
        .user = "USER",
    };
};
