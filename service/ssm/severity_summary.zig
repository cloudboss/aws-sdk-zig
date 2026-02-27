/// The number of managed nodes found for each patch severity level defined in
/// the request
/// filter.
pub const SeveritySummary = struct {
    /// The total number of resources or compliance items that have a severity level
    /// of
    /// `Critical`. Critical severity is determined by the organization that
    /// published the
    /// compliance items.
    critical_count: i32 = 0,

    /// The total number of resources or compliance items that have a severity level
    /// of high. High
    /// severity is determined by the organization that published the compliance
    /// items.
    high_count: i32 = 0,

    /// The total number of resources or compliance items that have a severity level
    /// of
    /// informational. Informational severity is determined by the organization that
    /// published the
    /// compliance items.
    informational_count: i32 = 0,

    /// The total number of resources or compliance items that have a severity level
    /// of low. Low
    /// severity is determined by the organization that published the compliance
    /// items.
    low_count: i32 = 0,

    /// The total number of resources or compliance items that have a severity level
    /// of medium.
    /// Medium severity is determined by the organization that published the
    /// compliance items.
    medium_count: i32 = 0,

    /// The total number of resources or compliance items that have a severity level
    /// of unspecified.
    /// Unspecified severity is determined by the organization that published the
    /// compliance
    /// items.
    unspecified_count: i32 = 0,

    pub const json_field_names = .{
        .critical_count = "CriticalCount",
        .high_count = "HighCount",
        .informational_count = "InformationalCount",
        .low_count = "LowCount",
        .medium_count = "MediumCount",
        .unspecified_count = "UnspecifiedCount",
    };
};
