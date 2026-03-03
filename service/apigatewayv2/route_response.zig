const aws = @import("aws");

const ParameterConstraints = @import("parameter_constraints.zig").ParameterConstraints;

/// Represents a route response.
pub const RouteResponse = struct {
    /// Represents the model selection expression of a route response. Supported
    /// only for WebSocket APIs.
    model_selection_expression: ?[]const u8 = null,

    /// Represents the response models of a route response.
    response_models: ?[]const aws.map.StringMapEntry = null,

    /// Represents the response parameters of a route response.
    response_parameters: ?[]const aws.map.MapEntry(ParameterConstraints) = null,

    /// Represents the identifier of a route response.
    route_response_id: ?[]const u8 = null,

    /// Represents the route response key of a route response.
    route_response_key: []const u8,

    pub const json_field_names = .{
        .model_selection_expression = "ModelSelectionExpression",
        .response_models = "ResponseModels",
        .response_parameters = "ResponseParameters",
        .route_response_id = "RouteResponseId",
        .route_response_key = "RouteResponseKey",
    };
};
