/// Specifies 1-10 occurrences of a specific type of sensitive data reported by
/// a finding.
pub const DetectedDataDetails = struct {
    /// An occurrence of the specified type of sensitive data. Each occurrence
    /// contains 1-128 characters.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
