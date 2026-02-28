const DashboardErrorType = @import("dashboard_error_type.zig").DashboardErrorType;
const Entity = @import("entity.zig").Entity;

/// Dashboard error.
pub const DashboardError = struct {
    /// Message.
    message: ?[]const u8,

    /// Type.
    @"type": ?DashboardErrorType,

    /// Lists the violated entities that caused the dashboard error.
    violated_entities: ?[]const Entity,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
        .violated_entities = "ViolatedEntities",
    };
};
