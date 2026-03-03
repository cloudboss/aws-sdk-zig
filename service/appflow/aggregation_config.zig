const AggregationType = @import("aggregation_type.zig").AggregationType;

/// The aggregation settings that you can use to customize the output format of
/// your flow
/// data.
pub const AggregationConfig = struct {
    /// Specifies whether Amazon AppFlow aggregates the flow records into a single
    /// file, or
    /// leave them unaggregated.
    aggregation_type: ?AggregationType = null,

    /// The desired file size, in MB, for each output file that Amazon AppFlow
    /// writes to the
    /// flow destination. For each file, Amazon AppFlow attempts to achieve the size
    /// that you
    /// specify. The actual file sizes might differ from this target based on the
    /// number and size of
    /// the records that each file contains.
    target_file_size: ?i64 = null,

    pub const json_field_names = .{
        .aggregation_type = "aggregationType",
        .target_file_size = "targetFileSize",
    };
};
