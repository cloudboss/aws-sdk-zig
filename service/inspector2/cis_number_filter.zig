/// The CIS number filter.
pub const CisNumberFilter = struct {
    /// The CIS number filter's lower inclusive.
    lower_inclusive: ?i32 = null,

    /// The CIS number filter's upper inclusive.
    upper_inclusive: ?i32 = null,

    pub const json_field_names = .{
        .lower_inclusive = "lowerInclusive",
        .upper_inclusive = "upperInclusive",
    };
};
