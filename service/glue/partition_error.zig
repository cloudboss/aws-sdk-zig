const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// Contains information about a partition error.
pub const PartitionError = struct {
    /// The details about the partition error.
    error_detail: ?ErrorDetail,

    /// The values that define the partition.
    partition_values: ?[]const []const u8,

    pub const json_field_names = .{
        .error_detail = "ErrorDetail",
        .partition_values = "PartitionValues",
    };
};
