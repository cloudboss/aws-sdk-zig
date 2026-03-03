const ImageInput = @import("image_input.zig").ImageInput;

/// Contains the body of the API response.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControlInvocationResults` field of the [InvokeAgent
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_RequestSyntax)
pub const ContentBody = struct {
    /// The body of the API response.
    body: ?[]const u8 = null,

    /// Lists details, including format and source, for the image in the response
    /// from the function call. You can specify only one image and the function in
    /// the `returnControlInvocationResults` must be a computer use action. For more
    /// information, see [Configure an Amazon Bedrock Agent to complete tasks with
    /// computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agent-computer-use.html).
    images: ?[]const ImageInput = null,

    pub const json_field_names = .{
        .body = "body",
        .images = "images",
    };
};
