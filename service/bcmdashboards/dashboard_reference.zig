const DashboardType = @import("dashboard_type.zig").DashboardType;

/// Contains basic information about a dashboard, including its ARN, name, type,
/// and timestamps.
pub const DashboardReference = struct {
    /// The ARN of the referenced dashboard.
    arn: []const u8,

    /// The timestamp when the dashboard was created.
    created_at: i64,

    /// The description of the referenced dashboard.
    description: ?[]const u8,

    /// The name of the referenced dashboard.
    name: []const u8,

    /// The dashboard type.
    @"type": DashboardType,

    /// The timestamp when the dashboard was last modified.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
