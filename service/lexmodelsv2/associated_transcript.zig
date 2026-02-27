/// The object containing information that associates the recommended
/// intent/slot type with a conversation.
pub const AssociatedTranscript = struct {
    /// The content of the transcript that meets the search filter criteria.
    /// For the JSON format of the transcript, see [Output transcript
    /// format](https://docs.aws.amazon.com/lexv2/latest/dg/designing-output-format.html).
    transcript: ?[]const u8,

    pub const json_field_names = .{
        .transcript = "transcript",
    };
};
