const HandOffTime = @import("hand_off_time.zig").HandOffTime;

/// Information about when an on-call shift begins and ends.
pub const CoverageTime = struct {
    /// Information about when the on-call rotation shift ends.
    end: ?HandOffTime = null,

    /// Information about when the on-call rotation shift begins.
    start: ?HandOffTime = null,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
