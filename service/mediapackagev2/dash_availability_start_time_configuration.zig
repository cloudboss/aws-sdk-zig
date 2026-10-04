/// The configuration for the DASH `availabilityStartTime` attribute of the
/// Media Presentation Description (MPD). Use this configuration to set a custom
/// availability start time for your DASH manifest.
pub const DashAvailabilityStartTimeConfiguration = union(enum) {
    /// The fixed availability start time for the DASH manifest, in ISO 8601
    /// date-time format. The value must have hourly granularity, meaning that the
    /// minutes, seconds, and fractional seconds must be zero. The value must be on
    /// or after `2024-01-01T00:00:00Z` and must be at least 14 days before the
    /// current time.
    fixed_availability_start_time: ?i64,

    pub const json_field_names = .{
        .fixed_availability_start_time = "FixedAvailabilityStartTime",
    };
};
