const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// Contains additional details about the context of the request. Verified
/// Permissions evaluates this information in an authorization request as part
/// of the `when` and `unless` clauses in a policy.
///
/// This data type is used as a request parameter for the
/// [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html), [BatchIsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorized.html), and [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) operations.
///
/// If you're passing context as part of the request, exactly one instance of
/// `context` must be passed. If you don't want to pass context, omit the
/// `context` parameter from your request rather than sending `context {}`.
///
/// Example:
/// `"context":{"contextMap":{"<KeyName1>":{"boolean":true},"<KeyName2>":{"long":1234}}}`
pub const ContextDefinition = union(enum) {
    /// A Cedar JSON string representation of the context needed to successfully
    /// evaluate an authorization request.
    ///
    /// Example: `{"cedarJson":"{\"<KeyName1>\": true, \"<KeyName2>\": 1234}" }`
    cedar_json: ?[]const u8,
    /// An list of attributes that are needed to successfully evaluate an
    /// authorization request. Each attribute in this array must include a map of a
    /// data type and its value.
    ///
    /// Example:
    /// `"contextMap":{"<KeyName1>":{"boolean":true},"<KeyName2>":{"long":1234}}`
    context_map: ?[]const aws.map.MapEntry(AttributeValue),

    pub const json_field_names = .{
        .cedar_json = "cedarJson",
        .context_map = "contextMap",
    };
};
