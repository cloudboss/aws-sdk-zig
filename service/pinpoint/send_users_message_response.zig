const aws = @import("aws");

const EndpointMessageResult = @import("endpoint_message_result.zig").EndpointMessageResult;

/// Provides information about which users and endpoints a message was sent to.
pub const SendUsersMessageResponse = struct {
    /// The unique identifier for the application that was used to send the message.
    application_id: []const u8,

    /// The unique identifier that was assigned to the message request.
    request_id: ?[]const u8,

    /// An object that indicates which endpoints the message was sent to, for each
    /// user. The object lists user IDs and, for each user ID, provides the endpoint
    /// IDs that the message was sent to. For each endpoint ID, it provides an
    /// EndpointMessageResult object.
    result: ?[]const aws.map.MapEntry([]const aws.map.MapEntry(EndpointMessageResult)),

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .request_id = "RequestId",
        .result = "Result",
    };
};
