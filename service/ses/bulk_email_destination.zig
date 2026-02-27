const Destination = @import("destination.zig").Destination;
const MessageTag = @import("message_tag.zig").MessageTag;

/// An array that contains one or more Destinations, as well as the tags and
/// replacement
/// data associated with each of those Destinations.
pub const BulkEmailDestination = struct {
    destination: Destination,

    /// A list of tags, in the form of name/value pairs, to apply to an email that
    /// you send
    /// using `SendBulkTemplatedEmail`. Tags correspond to characteristics of the
    /// email that you define, so that you can publish email sending events.
    replacement_tags: ?[]const MessageTag,

    /// A list of replacement values to apply to the template. This parameter is a
    /// JSON
    /// object, typically consisting of key-value pairs in which the keys correspond
    /// to
    /// replacement tags in the email template.
    replacement_template_data: ?[]const u8,
};
