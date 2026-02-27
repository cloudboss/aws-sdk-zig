/// This object contains the metadata for one `LiveTailSessionUpdate` structure.
/// It
/// indicates whether that update includes only a sample of 500 log events out
/// of a larger number
/// of ingested log events, or if it contains all of the matching log events
/// ingested during that
/// second of time.
pub const LiveTailSessionMetadata = struct {
    /// If this is `true`, then more than 500 log events matched the request for
    /// this
    /// update, and the `sessionResults` includes a sample of 500 of those events.
    ///
    /// If this is `false`, then 500 or fewer log events matched the request for
    /// this
    /// update, so no sampling was necessary. In this case, the `sessionResults`
    /// array
    /// includes all log events that matched your request during this time.
    sampled: bool = false,

    pub const json_field_names = .{
        .sampled = "sampled",
    };
};
