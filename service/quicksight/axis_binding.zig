pub const AxisBinding = enum {
    primary_yaxis,
    secondary_yaxis,

    pub const json_field_names = .{
        .primary_yaxis = "PRIMARY_YAXIS",
        .secondary_yaxis = "SECONDARY_YAXIS",
    };
};
