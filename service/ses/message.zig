const Body = @import("body.zig").Body;
const Content = @import("content.zig").Content;

/// Represents the message to be sent, composed of a subject and a body.
pub const Message = struct {
    /// The message body.
    body: Body,

    /// The subject of the message: A short summary of the content, which appears in
    /// the
    /// recipient's inbox.
    subject: Content,
};
