/// Specifies whether occurrences of sensitive data can be retrieved for a
/// finding. Possible values are:
pub const AvailabilityCode = enum {
    available,
    unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .unavailable = "UNAVAILABLE",
    };
};
