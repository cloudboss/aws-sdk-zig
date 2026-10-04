const GenerationStatus = @import("generation_status.zig").GenerationStatus;

/// Summary of a recommendation generation process initiated through the agent
/// API.
pub const AgentRecommendationGenerationSummary = struct {
    /// The timestamp when the generation was started.
    created_at: i64,

    /// The identifier of the user or system that started this generation.
    created_by: []const u8,

    /// The estimated time for the generation to complete.
    estimated_completion_time: ?i64 = null,

    /// The unique identifier of the recommendation generation.
    id: []const u8,

    /// The timestamp when the generation was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this generation.
    last_modified_by: ?[]const u8 = null,

    /// The name of the recommendation generation.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the profile used for this generation.
    profile_arn: []const u8,

    /// The current status of the recommendation generation.
    status: GenerationStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .estimated_completion_time = "estimatedCompletionTime",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .name = "name",
        .profile_arn = "profileArn",
        .status = "status",
    };
};
