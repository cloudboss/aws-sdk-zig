pub const DownlinkMode = enum {
    sequential,
    concurrent,
    using_uplink_gateway,

    pub const json_field_names = .{
        .sequential = "SEQUENTIAL",
        .concurrent = "CONCURRENT",
        .using_uplink_gateway = "USING_UPLINK_GATEWAY",
    };
};
