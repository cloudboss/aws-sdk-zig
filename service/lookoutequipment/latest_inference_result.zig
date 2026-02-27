pub const LatestInferenceResult = enum {
    anomalous,
    normal,

    pub const json_field_names = .{
        .anomalous = "ANOMALOUS",
        .normal = "NORMAL",
    };
};
