const FrequencyOption = @import("frequency_option.zig").FrequencyOption;

/// The cadence for Amazon Web Services to update the data export in your S3
/// bucket.
pub const RefreshCadence = struct {
    /// The frequency that data exports are updated. The export refreshes each time
    /// the source
    /// data updates, up to three times daily.
    frequency: FrequencyOption,

    pub const json_field_names = .{
        .frequency = "Frequency",
    };
};
