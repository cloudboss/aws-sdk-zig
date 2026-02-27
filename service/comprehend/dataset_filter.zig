const DatasetType = @import("dataset_type.zig").DatasetType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// Filter the datasets based on creation time or dataset status.
pub const DatasetFilter = struct {
    /// Filter the datasets to include datasets created after the specified time.
    creation_time_after: ?i64,

    /// Filter the datasets to include datasets created before the specified time.
    creation_time_before: ?i64,

    /// Filter the datasets based on the dataset type.
    dataset_type: ?DatasetType,

    /// Filter the datasets based on the dataset status.
    status: ?DatasetStatus,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .dataset_type = "DatasetType",
        .status = "Status",
    };
};
