/// Information about the imported model.
pub const ImportedModelSummary = struct {
    /// Creation time of the imported model.
    creation_time: i64,

    /// Specifies if the imported model supports converse.
    instruct_supported: ?bool,

    /// The architecture of the imported model.
    model_architecture: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the imported model.
    model_arn: []const u8,

    /// Name of the imported model.
    model_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .instruct_supported = "instructSupported",
        .model_architecture = "modelArchitecture",
        .model_arn = "modelArn",
        .model_name = "modelName",
    };
};
