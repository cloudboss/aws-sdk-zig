const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const DestinationDetail = @import("destination_detail.zig").DestinationDetail;
const DestinationState = @import("destination_state.zig").DestinationState;

/// Object specifying the status of a Destination.
pub const Destination = struct {
    /// Configuration used to create this destination.
    configuration: DestinationConfiguration,

    /// Optional details regarding the status of the destination.
    detail: ?DestinationDetail,

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
        .configuration = "configuration",
        .detail = "detail",
        .end_time = "endTime",
        .id = "id",
        .start_time = "startTime",
        .state = "state",
    };
};
