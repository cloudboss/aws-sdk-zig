/// Represents a data model for an API. Supported only for WebSocket APIs. See
/// [Create Models and Mapping Templates for Request and Response
/// Mappings](https://docs.aws.amazon.com/apigateway/latest/developerguide/models-mappings.html).
pub const Model = struct {
    /// The content-type for the model, for example, "application/json".
    content_type: ?[]const u8 = null,

    /// The description of the model.
    description: ?[]const u8 = null,

    /// The model identifier.
    model_id: ?[]const u8 = null,

    /// The name of the model. Must be alphanumeric.
    name: []const u8,

    /// The schema for the model. For application/json models, this should be JSON
    /// schema draft 4 model.
    schema: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .description = "Description",
        .model_id = "ModelId",
        .name = "Name",
        .schema = "Schema",
    };
};
