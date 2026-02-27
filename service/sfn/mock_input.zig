const MockErrorOutput = @import("mock_error_output.zig").MockErrorOutput;
const MockResponseValidationMode = @import("mock_response_validation_mode.zig").MockResponseValidationMode;

/// A JSON object that contains a mocked `result` or `errorOutput`.
pub const MockInput = struct {
    /// The mocked error output when calling TestState. When specified, the mocked
    /// response is returned as a JSON object that contains an `error` and `cause`
    /// field.
    error_output: ?MockErrorOutput,

    /// Determines the level of strictness when validating mocked results against
    /// their respective API models. Values include:
    ///
    /// * `STRICT`: All required fields must be present, and all present fields must
    ///   conform to the API's schema.
    ///
    /// * `PRESENT`: All present fields must conform to the API's schema.
    ///
    /// * `NONE`: No validation is performed.
    ///
    /// If no value is specified, the default value is `STRICT`.
    field_validation_mode: ?MockResponseValidationMode,

    /// A JSON string containing the mocked result of the state invocation.
    result: ?[]const u8,

    pub const json_field_names = .{
        .error_output = "errorOutput",
        .field_validation_mode = "fieldValidationMode",
        .result = "result",
    };
};
