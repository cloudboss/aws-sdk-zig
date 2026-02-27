const ManagedWorkgroupStatus = @import("managed_workgroup_status.zig").ManagedWorkgroupStatus;

/// A collection of Amazon Redshift compute resources managed by Glue.
pub const ManagedWorkgroupListItem = struct {
    /// The creation date of the managed workgroup.
    creation_date: ?i64,

    /// The unique identifier of the managed workgroup.
    managed_workgroup_id: ?[]const u8,

    /// The name of the managed workgroup.
    managed_workgroup_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the managed workgroup in the Glue Data
    /// Catalog.
    source_arn: ?[]const u8,

    /// The status of the managed workgroup.
    status: ?ManagedWorkgroupStatus,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .managed_workgroup_id = "managedWorkgroupId",
        .managed_workgroup_name = "managedWorkgroupName",
        .source_arn = "sourceArn",
        .status = "status",
    };
};
