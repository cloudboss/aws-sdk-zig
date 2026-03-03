const DashUtcTimingMode = @import("dash_utc_timing_mode.zig").DashUtcTimingMode;

/// Determines the type of UTC timing included in the DASH Media Presentation
/// Description (MPD).
pub const DashUtcTiming = struct {
    /// The UTC timing mode.
    timing_mode: ?DashUtcTimingMode = null,

    /// The the method that the player uses to synchronize to coordinated universal
    /// time (UTC) wall clock time.
    timing_source: ?[]const u8 = null,

    pub const json_field_names = .{
        .timing_mode = "TimingMode",
        .timing_source = "TimingSource",
    };
};
