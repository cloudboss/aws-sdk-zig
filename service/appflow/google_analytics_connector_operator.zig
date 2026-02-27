pub const GoogleAnalyticsConnectorOperator = enum {
    projection,
    between,

    pub const json_field_names = .{
        .projection = "PROJECTION",
        .between = "BETWEEN",
    };
};
