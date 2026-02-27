pub const StyledCellType = enum {
    total,
    metric_header,
    value,

    pub const json_field_names = .{
        .total = "TOTAL",
        .metric_header = "METRIC_HEADER",
        .value = "VALUE",
    };
};
