const HandlerBehavior = @import("handler_behavior.zig").HandlerBehavior;
const Integration = @import("integration.zig").Integration;

/// The configuration for a handler.
pub const HandlerConfig = struct {
    /// The behavior for the handler.
    behavior: HandlerBehavior,

    /// The integration data source configuration for the handler.
    integration: Integration,

    pub const json_field_names = .{
        .behavior = "behavior",
        .integration = "integration",
    };
};
