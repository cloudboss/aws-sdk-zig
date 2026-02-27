const aws = @import("aws");

const LimitsPerLabelSetEntry = @import("limits_per_label_set_entry.zig").LimitsPerLabelSetEntry;

/// This structure defines one label set used to enforce active time series
/// limits for the workspace, and defines the limit for that label set.
///
/// A label set is a unique combination of label-value pairs. Use them to
/// control time series limits and to monitor usage by specific label groups.
/// Example label sets might be `team:finance` or `env:prod`
pub const LimitsPerLabelSet = struct {
    /// This defines one label set that will have an enforced active time series
    /// limit.
    ///
    /// Label values accept ASCII characters and must contain at least one character
    /// that isn't whitespace. ASCII control characters are not accepted. If the
    /// label name is metric name label `__*name*__`, then the *metric* part of the
    /// name must conform to the following pattern: `[a-zA-Z_:][a-zA-Z0-9_:]*`
    label_set: []const aws.map.StringMapEntry,

    /// This structure contains the information about the limits that apply to time
    /// series that match this label set.
    limits: LimitsPerLabelSetEntry,

    pub const json_field_names = .{
        .label_set = "labelSet",
        .limits = "limits",
    };
};
