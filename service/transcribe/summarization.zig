/// Contains `GenerateAbstractiveSummary`, which is a required parameter if you
/// want to enable Generative call summarization in your Call Analytics request.
pub const Summarization = struct {
    /// Enables Generative call summarization in your Call Analytics request
    ///
    /// Generative call summarization provides a summary of the transcript including
    /// important
    /// components discussed in the conversation.
    ///
    /// For more information, see [Enabling generative call
    /// summarization](https://docs.aws.amazon.com/transcribe/latest/dg/tca-enable-summarization.html).
    generate_abstractive_summary: bool,

    pub const json_field_names = .{
        .generate_abstractive_summary = "GenerateAbstractiveSummary",
    };
};
