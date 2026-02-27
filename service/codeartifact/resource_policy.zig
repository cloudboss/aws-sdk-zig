/// An CodeArtifact resource policy that contains a resource ARN, document
/// details, and a revision.
pub const ResourcePolicy = struct {
    /// The resource policy formatted in JSON.
    document: ?[]const u8,

    /// The ARN of the resource associated with the resource policy
    resource_arn: ?[]const u8,

    /// The current revision of the resource policy.
    revision: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
        .resource_arn = "resourceArn",
        .revision = "revision",
    };
};
