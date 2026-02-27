pub const RecrawlBehavior = enum {
    crawl_everything,
    crawl_new_folders_only,
    crawl_event_mode,

    pub const json_field_names = .{
        .crawl_everything = "CRAWL_EVERYTHING",
        .crawl_new_folders_only = "CRAWL_NEW_FOLDERS_ONLY",
        .crawl_event_mode = "CRAWL_EVENT_MODE",
    };
};
