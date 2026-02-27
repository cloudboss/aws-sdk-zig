pub const Domain = enum {
    ecommerce,
    video_on_demand,

    pub const json_field_names = .{
        .ecommerce = "ECOMMERCE",
        .video_on_demand = "VIDEO_ON_DEMAND",
    };
};
