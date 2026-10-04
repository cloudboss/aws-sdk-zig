/// Specifies the minimum number of distinct identities for an individual output
/// column. This value overrides the table-wide `minimumIdentityCount` that you
/// set in `AggregationThreshold`.
pub const OutputColumnThreshold = struct {
    /// The minimum number of distinct identities that each query output group must
    /// represent for this column. Specify 0 to exempt the column from the
    /// threshold, or a value of 2 or greater to enforce a threshold.
    minimum_identity_count: i32,

    /// The name of the output column that the override applies to. You can specify
    /// each column only once.
    output_column_name: []const u8,

    pub const json_field_names = .{
        .minimum_identity_count = "minimumIdentityCount",
        .output_column_name = "outputColumnName",
    };
};
