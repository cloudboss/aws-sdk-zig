pub const RecommendationJobSupportedEndpointType = enum {
    realtime,
    serverless,

    pub const json_field_names = .{
        .realtime = "REALTIME",
        .serverless = "SERVERLESS",
    };
};
