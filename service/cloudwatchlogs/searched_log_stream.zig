/// Represents the search status of a log stream.
pub const SearchedLogStream = struct {
    /// The name of the log stream.
    log_stream_name: ?[]const u8,

    /// Indicates whether all the events in this log stream were searched.
    searched_completely: ?bool,

    pub const json_field_names = .{
        .log_stream_name = "logStreamName",
        .searched_completely = "searchedCompletely",
    };
};
