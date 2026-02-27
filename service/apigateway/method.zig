const aws = @import("aws");

const Integration = @import("integration.zig").Integration;
const MethodResponse = @import("method_response.zig").MethodResponse;

/// Represents a client-facing interface by which the client calls the API to
/// access back-end resources. A Method resource is
/// integrated with an Integration resource. Both consist of a request and one
/// or more responses. The method request takes
/// the client input that is passed to the back end through the integration
/// request. A method response returns the output from
/// the back end to the client through an integration response. A method request
/// is embodied in a Method resource, whereas
/// an integration request is embodied in an Integration resource. On the other
/// hand, a method response is represented
/// by a MethodResponse resource, whereas an integration response is represented
/// by an IntegrationResponse resource.
pub const Method = struct {
    /// A boolean flag specifying whether a valid ApiKey is required to invoke this
    /// method.
    api_key_required: ?bool,

    /// A list of authorization scopes configured on the method. The scopes are used
    /// with a `COGNITO_USER_POOLS` authorizer to authorize the method invocation.
    /// The authorization works by matching the method scopes against the scopes
    /// parsed from the access token in the incoming request. The method invocation
    /// is authorized if any method scopes matches a claimed scope in the access
    /// token. Otherwise, the invocation is not authorized. When the method scope is
    /// configured, the client must provide an access token instead of an identity
    /// token for authorization purposes.
    authorization_scopes: ?[]const []const u8,

    /// The method's authorization type. Valid values are `NONE` for open access,
    /// `AWS_IAM` for using AWS IAM permissions, `CUSTOM` for using a custom
    /// authorizer, or `COGNITO_USER_POOLS` for using a Cognito user pool.
    authorization_type: ?[]const u8,

    /// The identifier of an Authorizer to use on this method. The
    /// `authorizationType` must be `CUSTOM`.
    authorizer_id: ?[]const u8,

    /// The method's HTTP verb.
    http_method: ?[]const u8,

    /// Gets the method's integration responsible for passing the client-submitted
    /// request to the back end and performing necessary transformations to make the
    /// request compliant with the back end.
    method_integration: ?Integration,

    /// Gets a method response associated with a given HTTP status code.
    method_responses: ?[]const aws.map.MapEntry(MethodResponse),

    /// A human-friendly operation identifier for the method. For example, you can
    /// assign the `operationName` of `ListPets` for the `GET /pets` method in the
    /// `PetStore` example.
    operation_name: ?[]const u8,

    /// A key-value map specifying data schemas, represented by Model resources, (as
    /// the mapped value) of the request payloads of given content types (as the
    /// mapping key).
    request_models: ?[]const aws.map.StringMapEntry,

    /// A key-value map defining required or optional method request parameters that
    /// can be accepted by API Gateway. A key is a method request parameter name
    /// matching the pattern of `method.request.{location}.{name}`, where `location`
    /// is `querystring`, `path`, or `header` and `name` is a valid and unique
    /// parameter name. The value associated with the key is a Boolean flag
    /// indicating whether the parameter is required (`true`) or optional (`false`).
    /// The method request parameter names defined here are available in Integration
    /// to be mapped to integration request parameters or templates.
    request_parameters: ?[]const aws.map.MapEntry(bool),

    /// The identifier of a RequestValidator for request validation.
    request_validator_id: ?[]const u8,

    pub const json_field_names = .{
        .api_key_required = "apiKeyRequired",
        .authorization_scopes = "authorizationScopes",
        .authorization_type = "authorizationType",
        .authorizer_id = "authorizerId",
        .http_method = "httpMethod",
        .method_integration = "methodIntegration",
        .method_responses = "methodResponses",
        .operation_name = "operationName",
        .request_models = "requestModels",
        .request_parameters = "requestParameters",
        .request_validator_id = "requestValidatorId",
    };
};
