const LineageEventProcessingStatus = @import("lineage_event_processing_status.zig").LineageEventProcessingStatus;

/// The data lineage information.
pub const LineageInfo = struct {
    /// The data lineage error message.
    error_message: ?[]const u8 = null,

    /// The data lineage event ID.
    event_id: ?[]const u8 = null,

    /// The data lineage event status.
    event_status: ?LineageEventProcessingStatus = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .event_id = "eventId",
        .event_status = "eventStatus",
    };
};
