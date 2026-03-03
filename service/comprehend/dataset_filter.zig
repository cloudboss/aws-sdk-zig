const DatasetType = @import("dataset_type.zig").DatasetType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// Filter the datasets based on creation time or dataset status.
pub const DatasetFilter = struct {
    /// Filter the datasets to include datasets created after the specified time.
    creation_time_after: ?i64 = null,

    /// Filter the datasets to include datasets created before the specified time.
    creation_time_before: ?i64 = null,

    /// Filter the datasets based on the dataset type.
    dataset_type: ?DatasetType = null,

    /// Filter the datasets based on the dataset status.
    status: ?DatasetStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .dataset_type = "DatasetType",
        .status = "Status",
    };
};
