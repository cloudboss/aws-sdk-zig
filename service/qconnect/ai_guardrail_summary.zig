const aws = @import("aws");

const Status = @import("status.zig").Status;
const VisibilityStatus = @import("visibility_status.zig").VisibilityStatus;

/// The summary of the AI Guardrail.
pub const AIGuardrailSummary = struct {
    /// The Amazon Resource Name (ARN) of the AI Guardrail.
    ai_guardrail_arn: []const u8,

    /// The identifier of the Amazon Q in Connect AI Guardrail.
    ai_guardrail_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// A description of the AI Guardrail.
    description: ?[]const u8 = null,

    /// The time the AI Guardrail was last modified.
    modified_time: ?i64 = null,

    /// The name of the AI Guardrail.
    name: []const u8,

    /// The status of the AI Guardrail.
    status: ?Status = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The visibility status of the AI Guardrail.
    visibility_status: VisibilityStatus,

    pub const json_field_names = .{
        .ai_guardrail_arn = "aiGuardrailArn",
        .ai_guardrail_id = "aiGuardrailId",
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .description = "description",
        .modified_time = "modifiedTime",
        .name = "name",
        .status = "status",
        .tags = "tags",
        .visibility_status = "visibilityStatus",
    };
};
