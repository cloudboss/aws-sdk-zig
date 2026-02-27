const PeriodicScanFrequency = @import("periodic_scan_frequency.zig").PeriodicScanFrequency;

/// Configuration settings for periodic scans that run on a scheduled basis.
pub const PeriodicScanConfiguration = struct {
    /// The frequency at which periodic scans are performed (such as weekly or
    /// monthly).
    ///
    /// If you don't provide the `frequencyExpression` Amazon Inspector chooses day
    /// for the scan
    /// to run. If you provide the `frequencyExpression`, the schedule must match
    /// the
    /// specified `frequency`.
    frequency: ?PeriodicScanFrequency,

    /// The schedule expression for periodic scans, in cron format.
    frequency_expression: ?[]const u8,

    pub const json_field_names = .{
        .frequency = "frequency",
        .frequency_expression = "frequencyExpression",
    };
};
