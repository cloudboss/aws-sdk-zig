const TimecodeConfigSource = @import("timecode_config_source.zig").TimecodeConfigSource;

/// Timecode Config
pub const TimecodeConfig = struct {
    /// Identifies the source for the timecode that will be associated with the
    /// events outputs.
    /// -Embedded (embedded): Initialize the output timecode with timecode from the
    /// the source. If no embedded timecode is detected in the source, the system
    /// falls back to using "Start at 0" (zerobased).
    /// -System Clock (systemclock): Use the UTC time.
    /// -Start at 0 (zerobased): The time of the first frame of the event will be
    /// 00:00:00:00.
    source: TimecodeConfigSource,

    /// Threshold in frames beyond which output timecode is resynchronized to the
    /// input timecode. Discrepancies below this threshold are permitted to avoid
    /// unnecessary discontinuities in the output timecode. No timecode sync when
    /// this is not specified.
    sync_threshold: ?i32 = null,

    pub const json_field_names = .{
        .source = "Source",
        .sync_threshold = "SyncThreshold",
    };
};
