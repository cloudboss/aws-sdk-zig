const AWSResources = @import("aws_resources.zig").AWSResources;
const CodeReviewSettings = @import("code_review_settings.zig").CodeReviewSettings;

/// Represents an agent space, which is a dedicated workspace for securing a
/// specific application. An agent space contains the configuration, resources,
/// and settings needed for security testing.
pub const AgentSpace = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// The AWS resources associated with the agent space.
    aws_resources: ?AWSResources = null,

    /// The code review settings for the agent space.
    code_review_settings: ?CodeReviewSettings = null,

    /// The date and time the agent space was created, in UTC format.
    created_at: ?i64 = null,

    /// A description of the agent space.
    description: ?[]const u8 = null,

    /// The identifier of the AWS KMS key used to encrypt data in the agent space.
    kms_key_id: ?[]const u8 = null,

    /// The name of the agent space.
    name: []const u8,

    /// The list of target domain identifiers associated with the agent space.
    target_domain_ids: ?[]const []const u8 = null,

    /// The date and time the agent space was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .aws_resources = "awsResources",
        .code_review_settings = "codeReviewSettings",
        .created_at = "createdAt",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .target_domain_ids = "targetDomainIds",
        .updated_at = "updatedAt",
    };
};
