/// Specifies the message content for a custom channel message that's sent to
/// participants in a journey.
pub const JourneyCustomMessage = struct {
    /// The message content that's passed to an AWS Lambda function or to a web
    /// hook.
    data: ?[]const u8,

    pub const json_field_names = .{
        .data = "Data",
    };
};
