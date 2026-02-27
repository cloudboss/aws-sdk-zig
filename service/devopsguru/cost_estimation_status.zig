pub const CostEstimationStatus = enum {
    ongoing,
    completed,

    pub const json_field_names = .{
        .ongoing = "ONGOING",
        .completed = "COMPLETED",
    };
};
