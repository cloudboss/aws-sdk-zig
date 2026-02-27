const aws = @import("aws");

const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;

/// Represents an integration response.
pub const IntegrationResponse = struct {
    /// Supported only for WebSocket APIs. Specifies how to handle response payload
    /// content type conversions. Supported values are CONVERT_TO_BINARY and
    /// CONVERT_TO_TEXT, with the following behaviors:
    ///
    /// CONVERT_TO_BINARY: Converts a response payload from a Base64-encoded string
    /// to the corresponding binary blob.
    ///
    /// CONVERT_TO_TEXT: Converts a response payload from a binary blob to a
    /// Base64-encoded string.
    ///
    /// If this property is not defined, the response payload will be passed through
    /// from the integration response to the route response or method response
    /// without modification.
    content_handling_strategy: ?ContentHandlingStrategy,

    /// The integration response ID.
    integration_response_id: ?[]const u8,

    /// The integration response key.
    integration_response_key: []const u8,

    /// A key-value map specifying response parameters that are passed to the method
    /// response from the backend. The key is a method response header parameter
    /// name and the mapped value is an integration response header value, a static
    /// value enclosed within a pair of single quotes, or a JSON expression from the
    /// integration response body. The mapping key must match the pattern of
    /// method.response.header.{name}, where name is a valid and unique header name.
    /// The mapped non-static value must match the pattern of
    /// integration.response.header.{name} or
    /// integration.response.body.{JSON-expression}, where name is a valid and
    /// unique response header name and JSON-expression is a valid JSON expression
    /// without the $ prefix.
    response_parameters: ?[]const aws.map.StringMapEntry,

    /// The collection of response templates for the integration response as a
    /// string-to-string map of key-value pairs. Response templates are represented
    /// as a key/value map, with a content-type as the key and a template as the
    /// value.
    response_templates: ?[]const aws.map.StringMapEntry,

    /// The template selection expressions for the integration response.
    template_selection_expression: ?[]const u8,

    pub const json_field_names = .{
        .content_handling_strategy = "ContentHandlingStrategy",
        .integration_response_id = "IntegrationResponseId",
        .integration_response_key = "IntegrationResponseKey",
        .response_parameters = "ResponseParameters",
        .response_templates = "ResponseTemplates",
        .template_selection_expression = "TemplateSelectionExpression",
    };
};
