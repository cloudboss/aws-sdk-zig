/// Entity that comprises information abount unsupported timestamps in the
/// dataset.
pub const UnsupportedTimestamps = struct {
    /// Indicates the total number of unsupported timestamps across the ingested
    /// data.
    total_number_of_unsupported_timestamps: i32,

    pub const json_field_names = .{
        .total_number_of_unsupported_timestamps = "TotalNumberOfUnsupportedTimestamps",
    };
};
