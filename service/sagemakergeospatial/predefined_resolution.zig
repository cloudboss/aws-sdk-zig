pub const PredefinedResolution = enum {
    /// HIGHEST
    highest,
    /// LOWEST
    lowest,
    /// AVERAGE
    average,

    pub const json_field_names = .{
        .highest = "HIGHEST",
        .lowest = "LOWEST",
        .average = "AVERAGE",
    };
};
