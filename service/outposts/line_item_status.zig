pub const LineItemStatus = enum {
    preparing,
    building,
    shipped,
    delivered,
    installing,
    installed,
    @"error",
    cancelled,
    replaced,

    pub const json_field_names = .{
        .preparing = "PREPARING",
        .building = "BUILDING",
        .shipped = "SHIPPED",
        .delivered = "DELIVERED",
        .installing = "INSTALLING",
        .installed = "INSTALLED",
        .@"error" = "ERROR",
        .cancelled = "CANCELLED",
        .replaced = "REPLACED",
    };
};
