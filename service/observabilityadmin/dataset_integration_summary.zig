/// Contains summary information about a dataset integration, including its ARN,
/// associated IAM role, and creation and update timestamps, as returned by
/// `ListDatasetIntegrations`.
pub const DatasetIntegrationSummary = struct {
    /// The Amazon Resource Name (ARN) of the dataset integration.
    arn: []const u8,

    /// The timestamp when the dataset integration was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the dataset
    /// integration.
    role_arn: ?[]const u8 = null,

    /// The timestamp when the dataset integration was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .role_arn = "RoleArn",
        .updated_at = "UpdatedAt",
    };
};
