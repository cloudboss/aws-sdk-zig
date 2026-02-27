/// Contains trend statistics for a set of reports. The actual values depend on
/// the type of
/// trend being collected. For more information, see .
pub const ReportGroupTrendStats = struct {
    /// Contains the average of all values analyzed.
    average: ?[]const u8,

    /// Contains the maximum value analyzed.
    max: ?[]const u8,

    /// Contains the minimum value analyzed.
    min: ?[]const u8,

    pub const json_field_names = .{
        .average = "average",
        .max = "max",
        .min = "min",
    };
};
