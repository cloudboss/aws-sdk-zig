/// Storage tier for image sets
pub const StorageTier = enum {
    /// Frequent access storage tier for image sets that are accessed regularly
    frequent_access,
    /// Archive instant access storage tier for image sets that are accessed
    /// infrequently
    archive_instant_access,

    pub const json_field_names = .{
        .frequent_access = "FREQUENT_ACCESS",
        .archive_instant_access = "ARCHIVE_INSTANT_ACCESS",
    };
};
