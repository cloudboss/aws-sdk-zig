const MetaFlowHealthEntity = @import("meta_flow_health_entity.zig").MetaFlowHealthEntity;

/// Contains the overall health status and per-entity breakdown for a WhatsApp
/// Flow.
pub const MetaFlowHealthStatus = struct {
    /// The overall messaging availability status (for example, AVAILABLE, LIMITED,
    /// or BLOCKED).
    can_send_message: []const u8,

    /// A list of health status entities with per-entity availability information.
    entities: ?[]const MetaFlowHealthEntity = null,

    pub const json_field_names = .{
        .can_send_message = "canSendMessage",
        .entities = "entities",
    };
};
