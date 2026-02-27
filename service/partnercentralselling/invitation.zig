const Payload = @import("payload.zig").Payload;
const Receiver = @import("receiver.zig").Receiver;

/// The Invitation structure represents an invitation exchanged between partners
/// and AWS. It includes a message, receiver information, and a payload
/// providing context for the invitation.
pub const Invitation = struct {
    /// A message accompanying the invitation.
    message: []const u8,

    payload: Payload,

    receiver: Receiver,

    pub const json_field_names = .{
        .message = "Message",
        .payload = "Payload",
        .receiver = "Receiver",
    };
};
