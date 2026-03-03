const EventSourceName = @import("event_source_name.zig").EventSourceName;

/// The name of the event source. This field is required if `TriggerEventSource`
/// is one of the following values:
/// `OnZendeskTicketCreate` | `OnZendeskTicketStatusUpdate` |
/// `OnSalesforceCaseCreate`
/// | `OnContactEvaluationSubmit` | `OnMetricDataUpdate`.
pub const RuleTriggerEventSource = struct {
    /// The name of the event source.
    event_source_name: EventSourceName,

    /// The identifier for the integration association.
    integration_association_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_source_name = "EventSourceName",
        .integration_association_id = "IntegrationAssociationId",
    };
};
