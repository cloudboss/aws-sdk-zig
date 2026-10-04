const AIPromptType = @import("ai_prompt_type.zig").AIPromptType;
const ModelLifecycle = @import("model_lifecycle.zig").ModelLifecycle;

pub const ListModelsRequest = struct {
    /// The type of the AI Prompt to filter models by. When specified, only models
    /// that support the given AI Prompt type are returned.
    ai_prompt_type: ?AIPromptType = null,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN. The assistant's region determines
    /// which models are available.
    assistant_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The lifecycle status of models to filter by. When specified, only models
    /// with the given lifecycle status are returned.
    model_lifecycle: ?ModelLifecycle = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ai_prompt_type = "aiPromptType",
        .assistant_id = "assistantId",
        .max_results = "maxResults",
        .model_lifecycle = "modelLifecycle",
        .next_token = "nextToken",
    };
};
