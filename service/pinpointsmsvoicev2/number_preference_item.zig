const PreferenceType = @import("preference_type.zig").PreferenceType;

/// A single number preference that specifies how to match available phone
/// numbers. Each preference pairs a match type with one or more filter values.
pub const NumberPreferenceItem = struct {
    /// The digit pattern values to match against available phone numbers, using the
    /// specified preference type.
    filter: []const []const u8,

    /// The type of match to apply to the filter values.
    ///
    /// * `StartsWith`: Returns numbers that begin with the filter value.
    /// * `EndsWith`: Returns numbers that end with the filter value.
    /// * `Contains`: Returns numbers that contain the filter value.
    /// * `ExactMatch`: Returns the number that exactly matches the filter value.
    preference_type: []const PreferenceType,

    pub const json_field_names = .{
        .filter = "Filter",
        .preference_type = "PreferenceType",
    };
};
