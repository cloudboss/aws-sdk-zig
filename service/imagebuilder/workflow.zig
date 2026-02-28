const aws = @import("aws");

const WorkflowParameterDetail = @import("workflow_parameter_detail.zig").WorkflowParameterDetail;
const WorkflowState = @import("workflow_state.zig").WorkflowState;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Defines a process that Image Builder uses to build and test images during
/// the image creation process.
pub const Workflow = struct {
    /// The Amazon Resource Name (ARN) of the workflow resource.
    arn: ?[]const u8,

    /// Describes what change has been made in this version of the workflow, or
    /// what makes this version different from other versions of the workflow.
    change_description: ?[]const u8,

    /// Contains the YAML document content for the workflow.
    data: ?[]const u8,

    /// The timestamp when Image Builder created the workflow resource.
    date_created: ?[]const u8,

    /// The description of the workflow.
    description: ?[]const u8,

    /// The KMS key identifier used to encrypt the workflow resource. This can be
    /// either the Key ARN or the Alias ARN. For more information, see [Key
    /// identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,

    /// The name of the workflow resource.
    name: ?[]const u8,

    /// The owner of the workflow resource.
    owner: ?[]const u8,

    /// An array of input parameters that that the image workflow uses
    /// to control actions or configure settings.
    parameters: ?[]const WorkflowParameterDetail,

    /// Describes the current status of the workflow and the reason for
    /// that status.
    state: ?WorkflowState,

    /// The tags that apply to the workflow resource
    tags: ?[]const aws.map.StringMapEntry,

    /// Specifies the image creation stage that the workflow applies to. Image
    /// Builder
    /// currently supports build and test workflows.
    @"type": ?WorkflowType,

    /// The workflow resource version. Workflow resources are immutable.
    /// To make a change, you can clone a workflow or create a new version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .change_description = "changeDescription",
        .data = "data",
        .date_created = "dateCreated",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .owner = "owner",
        .parameters = "parameters",
        .state = "state",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
    };
};
