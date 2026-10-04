/// A contributor to an Amazon QuickSight space.
pub const SpaceContributor = struct {
    /// The percentage of total contributions made by the user.
    percentage: ?f64 = null,

    /// The raw file size in bytes contributed by the user.
    raw_file_size_bytes: i64,

    /// The user name of the contributor.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .percentage = "percentage",
        .raw_file_size_bytes = "rawFileSizeBytes",
        .user_name = "userName",
    };
};
