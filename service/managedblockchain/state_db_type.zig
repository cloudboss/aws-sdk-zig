pub const StateDBType = enum {
    level_db,
    couch_db,

    pub const json_field_names = .{
        .level_db = "LevelDB",
        .couch_db = "CouchDB",
    };
};
