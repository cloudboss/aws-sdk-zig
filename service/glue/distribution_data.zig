/// The distribution data for a statistic.
pub const DistributionData = struct {
    /// The bin edge values for the distribution.
    bin_edges: ?[]const []const u8 = null,

    /// The frequency count for each bin in the distribution.
    count: ?[]const i32 = null,

    /// The data type of the column for the distribution.
    data_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .bin_edges = "BinEdges",
        .count = "Count",
        .data_type = "DataType",
    };
};
