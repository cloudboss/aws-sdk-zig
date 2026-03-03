const aws = @import("aws");

const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// A workflow.
pub const WorkflowListItem = struct {
    /// The workflow's ARN.
    arn: ?[]const u8 = null,

    /// When the workflow was created.
    creation_time: ?i64 = null,

    /// The workflow's digest.
    digest: ?[]const u8 = null,

    /// The workflow's ID.
    id: ?[]const u8 = null,

    /// Any metadata available for workflow. The information listed may vary
    /// depending on the workflow, and there may also be no metadata to return.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The workflow's name.
    name: ?[]const u8 = null,

    /// The workflow's status.
    status: ?WorkflowStatus = null,

    /// The workflow's type.
    @"type": ?WorkflowType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .digest = "digest",
        .id = "id",
        .metadata = "metadata",
        .name = "name",
        .status = "status",
        .@"type" = "type",
    };
};
