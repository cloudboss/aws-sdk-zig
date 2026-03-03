const aws = @import("aws");

const PropertyParameters = @import("property_parameters.zig").PropertyParameters;

/// The request body to provide for the API request, as the agent elicited from
/// the user.
///
/// This data type is used in the following API operations:
///
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax)
pub const ApiRequestBody = struct {
    /// The content of the request body. The key of the object in this field is a
    /// media type defining the format of the request body.
    content: ?[]const aws.map.MapEntry(PropertyParameters) = null,

    pub const json_field_names = .{
        .content = "content",
    };
};
