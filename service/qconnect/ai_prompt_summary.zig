const aws = @import("aws");

const AIPromptAPIFormat = @import("ai_prompt_api_format.zig").AIPromptAPIFormat;
const Origin = @import("origin.zig").Origin;
const Status = @import("status.zig").Status;
const AIPromptTemplateType = @import("ai_prompt_template_type.zig").AIPromptTemplateType;
const AIPromptType = @import("ai_prompt_type.zig").AIPromptType;
const VisibilityStatus = @import("visibility_status.zig").VisibilityStatus;

/// The summary of the AI Prompt.
pub const AIPromptSummary = struct {
    /// The Amazon Resource Name (ARN) of the AI Prompt.
    ai_prompt_arn: []const u8,

    /// The identifier of the Amazon Q in Connect AI prompt.
    ai_prompt_id: []const u8,

    /// The API format used for this AI Prompt.
    api_format: AIPromptAPIFormat,

    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// The description of the AI Prompt.
    description: ?[]const u8 = null,

    /// The identifier of the model used for this AI Prompt. Model Ids supported
    /// are: `anthropic.claude-3-haiku-20240307-v1:0`.
    model_id: []const u8,

    /// The time the AI Prompt was last modified.
    modified_time: ?i64 = null,

    /// The name of the AI Prompt.
    name: []const u8,

    /// The origin of the AI Prompt. `SYSTEM` for a default AI Prompt created by Q
    /// in Connect or `CUSTOMER` for an AI Prompt created by calling AI Prompt
    /// creation APIs.
    origin: ?Origin = null,

    /// The status of the AI Prompt.
    status: ?Status = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the prompt template for this AI Prompt.
    template_type: AIPromptTemplateType,

    /// The type of this AI Prompt.
    @"type": AIPromptType,

    /// The visibility status of the AI Prompt.
    visibility_status: VisibilityStatus,

    pub const json_field_names = .{
        .ai_prompt_arn = "aiPromptArn",
        .ai_prompt_id = "aiPromptId",
        .api_format = "apiFormat",
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .description = "description",
        .model_id = "modelId",
        .modified_time = "modifiedTime",
        .name = "name",
        .origin = "origin",
        .status = "status",
        .tags = "tags",
        .template_type = "templateType",
        .@"type" = "type",
        .visibility_status = "visibilityStatus",
    };
};
