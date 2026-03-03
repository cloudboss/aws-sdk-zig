/// A set of validation rules for incoming Method requests.
pub const RequestValidator = struct {
    /// The identifier of this RequestValidator.
    id: ?[]const u8 = null,

    /// The name of this RequestValidator
    name: ?[]const u8 = null,

    /// A Boolean flag to indicate whether to validate a request body according to
    /// the configured Model schema.
    validate_request_body: bool = false,

    /// A Boolean flag to indicate whether to validate request parameters (`true`)
    /// or not (`false`).
    validate_request_parameters: bool = false,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .validate_request_body = "validateRequestBody",
        .validate_request_parameters = "validateRequestParameters",
    };
};
