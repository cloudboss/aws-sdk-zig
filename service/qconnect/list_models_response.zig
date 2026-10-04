const ModelSummary = @import("model_summary.zig").ModelSummary;

pub const ListModelsResponse = struct {
    /// The summaries of the models available to the assistant.
    model_summaries: []const ModelSummary,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_summaries = "modelSummaries",
        .next_token = "nextToken",
    };
};
