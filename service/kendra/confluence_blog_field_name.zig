pub const ConfluenceBlogFieldName = enum {
    author,
    display_url,
    item_type,
    labels,
    publish_date,
    space_key,
    space_name,
    url,
    version,

    pub const json_field_names = .{
        .author = "AUTHOR",
        .display_url = "DISPLAY_URL",
        .item_type = "ITEM_TYPE",
        .labels = "LABELS",
        .publish_date = "PUBLISH_DATE",
        .space_key = "SPACE_KEY",
        .space_name = "SPACE_NAME",
        .url = "URL",
        .version = "VERSION",
    };
};
