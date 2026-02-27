pub const TriangulationEventType = enum {
    aws,
    internet,

    pub const json_field_names = .{
        .aws = "AWS",
        .internet = "INTERNET",
    };
};
