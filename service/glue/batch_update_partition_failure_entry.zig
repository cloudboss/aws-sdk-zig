const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// Contains information about a batch update partition error.
pub const BatchUpdatePartitionFailureEntry = struct {
    /// The details about the batch update partition error.
    error_detail: ?ErrorDetail,

    /// A list of values defining the partitions.
    partition_value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .error_detail = "ErrorDetail",
        .partition_value_list = "PartitionValueList",
    };
};
