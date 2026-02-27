pub const PositionFiltering = enum {
    /// Filters device position updates according to their sample time
    time_based,
    /// Filters device position updates according to the distance between them
    distance_based,
    /// Filters device position updates according to their accuracy
    accuracy_based,

    pub const json_field_names = .{
        .time_based = "TimeBased",
        .distance_based = "DistanceBased",
        .accuracy_based = "AccuracyBased",
    };
};
