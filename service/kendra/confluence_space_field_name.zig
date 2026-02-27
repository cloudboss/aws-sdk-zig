pub const ConfluenceSpaceFieldName = enum {
    display_url,
    item_type,
    space_key,
    url,

    pub const json_field_names = .{
        .display_url = "DISPLAY_URL",
        .item_type = "ITEM_TYPE",
        .space_key = "SPACE_KEY",
        .url = "URL",
    };
};
