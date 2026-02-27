const DeliveryStatus = @import("delivery_status.zig").DeliveryStatus;

/// Provides information about the results of sending a message directly to an
/// endpoint address.
pub const MessageResult = struct {
    /// The delivery status of the message. Possible values are:
    ///
    /// * DUPLICATE - The endpoint address is a duplicate of another endpoint
    ///   address. Amazon Pinpoint won't attempt to send the message again.
    /// * OPT_OUT - The user who's associated with the endpoint address has opted
    ///   out of receiving messages from you. Amazon Pinpoint won't attempt to send
    ///   the message again.
    /// * PERMANENT_FAILURE - An error occurred when delivering the message to the
    ///   endpoint address. Amazon Pinpoint won't attempt to send the message again.
    /// * SUCCESSFUL - The message was successfully delivered to the endpoint
    ///   address.
    /// * TEMPORARY_FAILURE - A temporary error occurred. Amazon Pinpoint won't
    ///   attempt to send the message again.
    /// * THROTTLED - Amazon Pinpoint throttled the operation to send the message to
    ///   the endpoint address.
    /// * UNKNOWN_FAILURE - An unknown error occurred.
    delivery_status: DeliveryStatus,

    /// The unique identifier for the message that was sent.
    message_id: ?[]const u8,

    /// The downstream service status code for delivering the message.
    status_code: i32,

    /// The status message for delivering the message.
    status_message: ?[]const u8,

    /// For push notifications that are sent through the GCM channel, specifies
    /// whether the endpoint's device registration token was updated as part of
    /// delivering the message.
    updated_token: ?[]const u8,

    pub const json_field_names = .{
        .delivery_status = "DeliveryStatus",
        .message_id = "MessageId",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
        .updated_token = "UpdatedToken",
    };
};
