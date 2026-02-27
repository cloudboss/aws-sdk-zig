const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// Contains information about the specific data set, including name, ARN, and
/// status.
pub const DatasetSummary = struct {
    /// The time at which the dataset was created in Amazon Lookout for Equipment.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) of the specified dataset.
    dataset_arn: ?[]const u8,

    /// The name of the dataset.
    dataset_name: ?[]const u8,

    /// Indicates the status of the dataset.
    status: ?DatasetStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .status = "Status",
    };
};
