pub const AutoAdjustType = enum {
    historical,
    forecast,

    pub const json_field_names = .{
        .historical = "HISTORICAL",
        .forecast = "FORECAST",
    };
};
