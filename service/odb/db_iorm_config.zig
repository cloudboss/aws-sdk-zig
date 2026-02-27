/// The IORM configuration settings for the database.
pub const DbIormConfig = struct {
    /// The database name. For the default DbPlan, the dbName is `default`.
    db_name: ?[]const u8,

    /// The flash cache limit for this database. This value is internally configured
    /// based on the share value assigned to the database.
    flash_cache_limit: ?[]const u8,

    /// The relative priority of this database.
    share: ?i32,

    pub const json_field_names = .{
        .db_name = "dbName",
        .flash_cache_limit = "flashCacheLimit",
        .share = "share",
    };
};
