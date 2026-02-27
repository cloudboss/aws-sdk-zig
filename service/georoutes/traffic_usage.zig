pub const TrafficUsage = enum {
    ignore_traffic_data,
    use_traffic_data,

    pub const json_field_names = .{
        .ignore_traffic_data = "IGNORE_TRAFFIC_DATA",
        .use_traffic_data = "USE_TRAFFIC_DATA",
    };
};
