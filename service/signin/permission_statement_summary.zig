const aws = @import("aws");

/// Summary of a permission statement
pub const PermissionStatementSummary = struct {
    /// Condition block for the permission statement
    condition: ?[]const aws.map.MapEntry([]const aws.map.MapEntry([]const []const u8)) = null,

    /// Unique identifier for the permission statement
    sid: []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .sid = "sid",
    };
};
