const ScheduledQueryDestinationType = @import("scheduled_query_destination_type.zig").ScheduledQueryDestinationType;
const ActionStatus = @import("action_status.zig").ActionStatus;

/// Information about a destination where scheduled query results are processed,
/// including
/// processing status and any error messages.
pub const ScheduledQueryDestination = struct {
    /// The identifier for the destination where results are delivered.
    destination_identifier: ?[]const u8,

    /// The type of destination for query results.
    destination_type: ?ScheduledQueryDestinationType,

    /// Error message if destination processing failed.
    error_message: ?[]const u8,

    /// The identifier of the processed result at the destination.
    processed_identifier: ?[]const u8,

    /// The processing status of the destination delivery.
    status: ?ActionStatus,

    pub const json_field_names = .{
        .destination_identifier = "destinationIdentifier",
        .destination_type = "destinationType",
        .error_message = "errorMessage",
        .processed_identifier = "processedIdentifier",
        .status = "status",
    };
};
