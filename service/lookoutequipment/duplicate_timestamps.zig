/// Entity that comprises information abount duplicate timestamps in the
/// dataset.
pub const DuplicateTimestamps = struct {
    /// Indicates the total number of duplicate timestamps.
    total_number_of_duplicate_timestamps: i32,

    pub const json_field_names = .{
        .total_number_of_duplicate_timestamps = "TotalNumberOfDuplicateTimestamps",
    };
};
