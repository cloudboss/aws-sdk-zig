/// Describes a data artifact within a Data Exchange fulfillment option.
pub const DataArtifact = struct {
    /// The classification of sensitive data contained in the dataset.
    data_classification: []const u8,

    /// A description of the data artifact.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the data artifact.
    resource_arn: ?[]const u8 = null,

    /// The type of the data artifact resource.
    resource_type: []const u8,

    pub const json_field_names = .{
        .data_classification = "dataClassification",
        .description = "description",
        .resource_arn = "resourceArn",
        .resource_type = "resourceType",
    };
};
