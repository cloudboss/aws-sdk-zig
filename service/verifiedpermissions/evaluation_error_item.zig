/// Contains a description of an evaluation error.
///
/// This data type is a response parameter of the
/// [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html), [BatchIsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorized.html), and [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) operations.
pub const EvaluationErrorItem = struct {
    /// The error description.
    error_description: []const u8,

    pub const json_field_names = .{
        .error_description = "errorDescription",
    };
};
