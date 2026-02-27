/// The severity of a finding, ranging from LOW, for least severe, to HIGH, for
/// most severe. Valid values are:
pub const DataIdentifierSeverity = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
