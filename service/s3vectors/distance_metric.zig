pub const DistanceMetric = enum {
    euclidean,
    cosine,

    pub const json_field_names = .{
        .euclidean = "EUCLIDEAN",
        .cosine = "COSINE",
    };
};
