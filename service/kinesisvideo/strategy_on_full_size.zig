pub const StrategyOnFullSize = enum {
    delete_oldest_media,
    deny_new_media,

    pub const json_field_names = .{
        .delete_oldest_media = "DELETE_OLDEST_MEDIA",
        .deny_new_media = "DENY_NEW_MEDIA",
    };
};
