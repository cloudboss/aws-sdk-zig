const aws = @import("aws");

const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;

/// Represents an integration response. The status code must map to an existing
/// MethodResponse, and parameters and templates can be used to transform the
/// back-end response.
pub const IntegrationResponse = struct {
    /// Specifies how to handle response payload content type conversions. Supported
    /// values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following
    /// behaviors:
    ///
    /// If this property is not defined, the response payload will be passed through
    /// from the integration response to the method response without modification.
    content_handling: ?ContentHandlingStrategy,

    /// A key-value map specifying response parameters that are passed to the method
    /// response from the back end.
    /// The key is a method response header parameter name and the mapped value is
    /// an integration response header value, a static value enclosed within a pair
    /// of single quotes, or a JSON expression from the integration response body.
    /// The mapping key must match the pattern of `method.response.header.{name}`,
    /// where `name` is a valid and unique header name. The mapped non-static value
    /// must match the pattern of `integration.response.header.{name}` or
    /// `integration.response.body.{JSON-expression}`, where `name` is a valid and
    /// unique response header name and `JSON-expression` is a valid JSON expression
    /// without the `$` prefix.
    response_parameters: ?[]const aws.map.StringMapEntry,

    /// Specifies the templates used to transform the integration response body.
    /// Response templates are represented as a key/value map, with a content-type
    /// as the key and a template as the value.
    response_templates: ?[]const aws.map.StringMapEntry,

    /// Specifies the regular expression (regex) pattern used to choose an
    /// integration response based on the response from the back end. For example,
    /// if the success response returns nothing and the error response returns some
    /// string, you could use the `.+` regex to match error response. However, make
    /// sure that the error response does not contain any newline (`\n`) character
    /// in such cases. If the back end is an Lambda function, the Lambda function
    /// error header is matched. For all other HTTP and Amazon Web Services back
    /// ends, the HTTP status code is matched.
    selection_pattern: ?[]const u8,

    /// Specifies the status code that is used to map the integration response to an
    /// existing MethodResponse.
    status_code: ?[]const u8,

    pub const json_field_names = .{
        .content_handling = "contentHandling",
        .response_parameters = "responseParameters",
        .response_templates = "responseTemplates",
        .selection_pattern = "selectionPattern",
        .status_code = "statusCode",
    };
};
