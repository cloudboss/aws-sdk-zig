/// Represents a single entity in the health status check for a WhatsApp Flow.
pub const MetaFlowHealthEntity = struct {
    /// The messaging availability status for this entity (for example, AVAILABLE,
    /// LIMITED, or BLOCKED).
    can_send_message: []const u8,

    /// The type of entity (for example, FLOW, WABA, BUSINESS, or APP).
    entity_type: []const u8,

    /// The unique identifier of the entity.
    id: []const u8,

    pub const json_field_names = .{
        .can_send_message = "canSendMessage",
        .entity_type = "entityType",
        .id = "id",
    };
};
