/// The IAM Identity details associated with the user. These details are
/// associated with model package groups, model packages and project entities
/// only.
pub const IamIdentity = struct {
    /// The Amazon Resource Name (ARN) of the IAM identity.
    arn: ?[]const u8 = null,

    /// The ID of the principal that assumes the IAM identity.
    principal_id: ?[]const u8 = null,

    /// The person or application which assumes the IAM identity.
    source_identity: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .principal_id = "PrincipalId",
        .source_identity = "SourceIdentity",
    };
};
