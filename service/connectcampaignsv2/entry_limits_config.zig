/// Campaign entry limits config
pub const EntryLimitsConfig = struct {
    /// Maximum number of times a participant can enter the campaign. A value of 0
    /// indicates unlimited entries. Values of 1 or greater specify the exact number
    /// of entries allowed.
    max_entry_count: i32,

    /// Minimum time interval that must pass before a participant can enter the
    /// campaign again.
    min_entry_interval: []const u8,

    pub const json_field_names = .{
        .max_entry_count = "maxEntryCount",
        .min_entry_interval = "minEntryInterval",
    };
};
