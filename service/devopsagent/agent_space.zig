const aws = @import("aws");

/// Represents a complete AgentSpace with all its properties, timestamps,
/// encryption settings, and unique identifier.
pub const AgentSpace = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    /// The timestamp when the resource was created.
    created_at: i64,

    /// The description of the AgentSpace.
    description: ?[]const u8 = null,

    /// The ARN of the AWS Key Management Service (AWS KMS) customer managed key
    /// that's used to encrypt resources.
    kms_key_arn: ?[]const u8 = null,

    /// The locale for the AgentSpace, which determines the language used in agent
    /// responses.
    locale: ?[]const u8 = null,

    /// The name of the AgentSpace.
    name: []const u8,

    /// The preferences configured on the agent space. Preferences that are not set
    /// take their default values.
    preferences: ?[]const aws.map.MapEntry(bool) = null,

    /// The timestamp when the resource was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .locale = "locale",
        .name = "name",
        .preferences = "preferences",
        .updated_at = "updatedAt",
    };
};
