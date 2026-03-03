/// The counter that describes a DDoS attack.
pub const SummarizedCounter = struct {
    /// The average value of the counter for a specified time period.
    average: f64 = 0,

    /// The maximum value of the counter for a specified time period.
    max: f64 = 0,

    /// The number of counters for a specified time period.
    n: i32 = 0,

    /// The counter name.
    name: ?[]const u8 = null,

    /// The total of counter values for a specified time period.
    sum: f64 = 0,

    /// The unit of the counters.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .average = "Average",
        .max = "Max",
        .n = "N",
        .name = "Name",
        .sum = "Sum",
        .unit = "Unit",
    };
};
