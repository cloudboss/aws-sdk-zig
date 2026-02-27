/// A structure that defines the time range that you want to retrieve results
/// from.
pub const TimeRange = struct {
    /// The beginning of the time range to retrieve performance events from.
    after: i64 = 0,

    /// The end of the time range to retrieve performance events from. If you omit
    /// this, the time range extends to the time that this operation is performed.
    before: i64 = 0,

    pub const json_field_names = .{
        .after = "After",
        .before = "Before",
    };
};
