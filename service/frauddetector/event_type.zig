const EventIngestion = @import("event_ingestion.zig").EventIngestion;
const EventOrchestration = @import("event_orchestration.zig").EventOrchestration;
const IngestedEventStatistics = @import("ingested_event_statistics.zig").IngestedEventStatistics;

/// The event type details.
pub const EventType = struct {
    /// The entity type ARN.
    arn: ?[]const u8,

    /// Timestamp of when the event type was created.
    created_time: ?[]const u8,

    /// The event type description.
    description: ?[]const u8,

    /// The event type entity types.
    entity_types: ?[]const []const u8,

    /// If `Enabled`, Amazon Fraud Detector stores event data when you generate a
    /// prediction and uses that data to update calculated variables in near
    /// real-time. Amazon Fraud Detector uses this data, known as `INGESTED_EVENTS`,
    /// to train your model and improve fraud predictions.
    event_ingestion: ?EventIngestion,

    /// The event orchestration status.
    event_orchestration: ?EventOrchestration,

    /// The event type event variables.
    event_variables: ?[]const []const u8,

    /// Data about the stored events.
    ingested_event_statistics: ?IngestedEventStatistics,

    /// The event type labels.
    labels: ?[]const []const u8,

    /// Timestamp of when the event type was last updated.
    last_updated_time: ?[]const u8,

    /// The event type name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .entity_types = "entityTypes",
        .event_ingestion = "eventIngestion",
        .event_orchestration = "eventOrchestration",
        .event_variables = "eventVariables",
        .ingested_event_statistics = "ingestedEventStatistics",
        .labels = "labels",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
