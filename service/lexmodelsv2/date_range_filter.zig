/// The object used for specifying the data range that the customer
/// wants Amazon Lex to read through in the input transcripts.
pub const DateRangeFilter = struct {
    /// A timestamp indicating the end date for the date range
    /// filter.
    end_date_time: i64,

    /// A timestamp indicating the start date for the date range
    /// filter.
    start_date_time: i64,

    pub const json_field_names = .{
        .end_date_time = "endDateTime",
        .start_date_time = "startDateTime",
    };
};
