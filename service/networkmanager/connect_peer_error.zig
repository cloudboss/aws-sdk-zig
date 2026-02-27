const ConnectPeerErrorCode = @import("connect_peer_error_code.zig").ConnectPeerErrorCode;

/// Describes an error associated with a Connect peer request
pub const ConnectPeerError = struct {
    /// The error code for the Connect peer request.
    code: ?ConnectPeerErrorCode,

    /// The message associated with the error `code`.
    message: ?[]const u8,

    /// The ID of the Connect peer request.
    request_id: ?[]const u8,

    /// The ARN of the requested Connect peer resource.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .request_id = "RequestId",
        .resource_arn = "ResourceArn",
    };
};
