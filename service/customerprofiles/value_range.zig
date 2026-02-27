/// A structure letting customers specify a relative time window over which over
/// which data
/// is included in the Calculated Attribute. Use positive numbers to indicate
/// that the endpoint
/// is in the past, and negative numbers to indicate it is in the future.
/// ValueRange overrides
/// Value.
pub const ValueRange = struct {
    /// The end time of when to include objects. Use positive numbers to indicate
    /// that the
    /// starting point is in the past, and negative numbers to indicate it is in the
    /// future.
    end: i32,

    /// The start time of when to include objects. Use positive numbers to indicate
    /// that the
    /// starting point is in the past, and negative numbers to indicate it is in the
    /// future.
    start: i32,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
