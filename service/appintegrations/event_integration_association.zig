const aws = @import("aws");

/// The event integration association.
pub const EventIntegrationAssociation = struct {
    /// The metadata associated with the client.
    client_association_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The identifier for the client that is associated with the event integration.
    client_id: ?[]const u8 = null,

    /// The name of the EventBridge rule.
    event_bridge_rule_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the event integration association.
    event_integration_association_arn: ?[]const u8 = null,

    /// The identifier for the event integration association.
    event_integration_association_id: ?[]const u8 = null,

    /// The name of the event integration.
    event_integration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_association_metadata = "ClientAssociationMetadata",
        .client_id = "ClientId",
        .event_bridge_rule_name = "EventBridgeRuleName",
        .event_integration_association_arn = "EventIntegrationAssociationArn",
        .event_integration_association_id = "EventIntegrationAssociationId",
        .event_integration_name = "EventIntegrationName",
    };
};
