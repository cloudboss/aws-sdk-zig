const DestinationState = @import("destination_state.zig").DestinationState;

/// Summary information about a Destination.
pub const DestinationSummary = struct {
    /// UTC time of the destination end. This is an ISO 8601 timestamp; *note that
    /// this
    /// is returned as a string*.
    end_time: ?i64,

    /// Unique identifier for this destination, assigned by IVS.
    id: []const u8,

    /// UTC time of the destination start. This is an ISO 8601 timestamp; *note that
    /// this is returned as a string*.
    start_time: ?i64,

    /// State of the Composition Destination.
    state: DestinationState,

    pub const json_field_names = .{
        .end_time = "endTime",
        .id = "id",
        .start_time = "startTime",
        .state = "state",
    };
};
