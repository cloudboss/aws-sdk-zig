const ModelTypeEnum = @import("model_type_enum.zig").ModelTypeEnum;

/// The model version.
pub const ModelVersion = struct {
    /// The model version ARN.
    arn: ?[]const u8,

    /// The model ID.
    model_id: []const u8,

    /// The model type.
    model_type: ModelTypeEnum,

    /// The model version number.
    model_version_number: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .model_id = "modelId",
        .model_type = "modelType",
        .model_version_number = "modelVersionNumber",
    };
};
