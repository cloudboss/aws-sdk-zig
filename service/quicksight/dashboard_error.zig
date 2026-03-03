const DashboardErrorType = @import("dashboard_error_type.zig").DashboardErrorType;
const Entity = @import("entity.zig").Entity;

/// Dashboard error.
pub const DashboardError = struct {
    /// Message.
    message: ?[]const u8 = null,

    /// Type.
    @"type": ?DashboardErrorType = null,

    /// Lists the violated entities that caused the dashboard error.
    violated_entities: ?[]const Entity = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
        .violated_entities = "ViolatedEntities",
    };
};
