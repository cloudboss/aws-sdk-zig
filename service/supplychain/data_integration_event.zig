const DataIntegrationEventDatasetTargetDetails = @import("data_integration_event_dataset_target_details.zig").DataIntegrationEventDatasetTargetDetails;
const DataIntegrationEventType = @import("data_integration_event_type.zig").DataIntegrationEventType;

/// The data integration event details.
pub const DataIntegrationEvent = struct {
    /// The target dataset details for a DATASET event type.
    dataset_target_details: ?DataIntegrationEventDatasetTargetDetails = null,

    /// Event identifier (for example, orderId for InboundOrder) used for data
    /// sharding or partitioning.
    event_group_id: []const u8,

    /// The unique event identifier.
    event_id: []const u8,

    /// The event timestamp (in epoch seconds).
    event_timestamp: i64,

    /// The data event type.
    event_type: DataIntegrationEventType,

    /// The AWS Supply Chain instance identifier.
    instance_id: []const u8,

    pub const json_field_names = .{
        .dataset_target_details = "datasetTargetDetails",
        .event_group_id = "eventGroupId",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .event_type = "eventType",
        .instance_id = "instanceId",
    };
};
