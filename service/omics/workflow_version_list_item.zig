const aws = @import("aws");

const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// A list of workflow version items.
pub const WorkflowVersionListItem = struct {
    /// ARN of the workflow version.
    arn: ?[]const u8 = null,

    /// The creation time of the workflow version.
    creation_time: ?i64 = null,

    /// The description of the workflow version.
    description: ?[]const u8 = null,

    /// The digist of the workflow version.
    digest: ?[]const u8 = null,

    /// Metadata for the workflow version.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The status of the workflow version.
    status: ?WorkflowStatus = null,

    /// The type of the workflow version.
    @"type": ?WorkflowType = null,

    /// The name of the workflow version.
    version_name: ?[]const u8 = null,

    /// The workflow's ID.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .digest = "digest",
        .metadata = "metadata",
        .status = "status",
        .@"type" = "type",
        .version_name = "versionName",
        .workflow_id = "workflowId",
    };
};
