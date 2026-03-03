const Partition = @import("partition.zig").Partition;

/// A partition that contains unfiltered metadata.
pub const UnfilteredPartition = struct {
    /// The list of columns the user has permissions to access.
    authorized_columns: ?[]const []const u8 = null,

    /// A Boolean value indicating that the partition location is registered with
    /// Lake Formation.
    is_registered_with_lake_formation: bool = false,

    /// The partition object.
    partition: ?Partition = null,

    pub const json_field_names = .{
        .authorized_columns = "AuthorizedColumns",
        .is_registered_with_lake_formation = "IsRegisteredWithLakeFormation",
        .partition = "Partition",
    };
};
