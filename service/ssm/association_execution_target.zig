const OutputSource = @import("output_source.zig").OutputSource;

/// Includes information about the specified association execution.
pub const AssociationExecutionTarget = struct {
    /// The association ID.
    association_id: ?[]const u8 = null,

    /// The association version.
    association_version: ?[]const u8 = null,

    /// Detailed information about the execution status.
    detailed_status: ?[]const u8 = null,

    /// The execution ID.
    execution_id: ?[]const u8 = null,

    /// The date of the last execution.
    last_execution_date: ?i64 = null,

    /// The location where the association details are saved.
    output_source: ?OutputSource = null,

    /// The resource ID, for example, the managed node ID where the association ran.
    resource_id: ?[]const u8 = null,

    /// The resource type, for example, EC2.
    resource_type: ?[]const u8 = null,

    /// The association execution status.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .association_version = "AssociationVersion",
        .detailed_status = "DetailedStatus",
        .execution_id = "ExecutionId",
        .last_execution_date = "LastExecutionDate",
        .output_source = "OutputSource",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .status = "Status",
    };
};
