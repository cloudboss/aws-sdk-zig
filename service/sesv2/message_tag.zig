/// Contains the name and value of a tag that you apply to an email. You can use
/// message
/// tags when you publish email sending events.
pub const MessageTag = struct {
    /// The name of the message tag. The message tag name has to meet the following
    /// criteria:
    ///
    /// * It can only contain ASCII letters (a–z, A–Z), numbers (0–9),
    /// underscores (_), or dashes (-).
    ///
    /// * It can contain no more than 256 characters.
    name: []const u8,

    /// The value of the message tag. The message tag value has to meet the
    /// following
    /// criteria:
    ///
    /// * It can only contain ASCII letters (a–z, A–Z), numbers (0–9),
    /// underscores (_), or dashes (-).
    ///
    /// * It can contain no more than 256 characters.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
