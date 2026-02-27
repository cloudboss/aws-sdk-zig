pub const TrafficShapingType = enum {
    retrieval_window,
    tps,

    pub const json_field_names = .{
        .retrieval_window = "RETRIEVAL_WINDOW",
        .tps = "TPS",
    };
};
