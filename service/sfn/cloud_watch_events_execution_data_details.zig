/// Provides details about execution input or output.
pub const CloudWatchEventsExecutionDataDetails = struct {
    /// Indicates whether input or output was included in the response. Always
    /// `true`
    /// for API calls.
    included: bool = false,

    pub const json_field_names = .{
        .included = "included",
    };
};
