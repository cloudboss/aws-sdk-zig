/// The qualitative representation of the finding's severity. Possible values
/// are:
pub const SeverityDescription = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "Low",
        .medium = "Medium",
        .high = "High",
    };
};
