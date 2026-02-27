const ModelTypeEnum = @import("model_type_enum.zig").ModelTypeEnum;

/// The model.
pub const Model = struct {
    /// The ARN of the model.
    arn: ?[]const u8,

    /// Timestamp of when the model was created.
    created_time: ?[]const u8,

    /// The model description.
    description: ?[]const u8,

    /// The name of the event type.
    event_type_name: ?[]const u8,

    /// Timestamp of last time the model was updated.
    last_updated_time: ?[]const u8,

    /// The model ID.
    model_id: ?[]const u8,

    /// The model type.
    model_type: ?ModelTypeEnum,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .event_type_name = "eventTypeName",
        .last_updated_time = "lastUpdatedTime",
        .model_id = "modelId",
        .model_type = "modelType",
    };
};
