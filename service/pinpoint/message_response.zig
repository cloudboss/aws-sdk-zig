const aws = @import("aws");

const EndpointMessageResult = @import("endpoint_message_result.zig").EndpointMessageResult;
const MessageResult = @import("message_result.zig").MessageResult;

/// Provides information about the results of a request to send a message to an
/// endpoint address.
pub const MessageResponse = struct {
    /// The unique identifier for the application that was used to send the message.
    application_id: []const u8,

    /// A map that contains a multipart response for each address that the message
    /// was sent to. In the map, the endpoint ID is the key and the result is the
    /// value.
    endpoint_result: ?[]const aws.map.MapEntry(EndpointMessageResult) = null,

    /// The identifier for the original request that the message was delivered for.
    request_id: ?[]const u8 = null,

    /// A map that contains a multipart response for each address (email address,
    /// phone number, or push notification token) that the message was sent to. In
    /// the map, the address is the key and the result is the value.
    result: ?[]const aws.map.MapEntry(MessageResult) = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .endpoint_result = "EndpointResult",
        .request_id = "RequestId",
        .result = "Result",
    };
};
