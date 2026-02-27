pub const LineItemFilterAttributeName = enum {
    line_item_type,
    service,

    pub const json_field_names = .{
        .line_item_type = "LINE_ITEM_TYPE",
        .service = "SERVICE",
    };
};
