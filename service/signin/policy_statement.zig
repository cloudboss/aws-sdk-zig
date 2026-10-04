const aws = @import("aws");

/// Individual policy statement within a resource-based policy
pub const PolicyStatement = struct {
    /// Actions the statement controls
    action: ?[]const []const u8 = null,

    /// Condition block for the statement
    condition: ?[]const aws.map.MapEntry([]const aws.map.MapEntry([]const []const u8)) = null,

    /// Effect of the policy statement (Allow/Deny)
    effect: ?[]const u8 = null,

    /// Principal the statement applies to
    principal: ?[]const aws.map.StringMapEntry = null,

    /// Resource the statement applies to
    resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .condition = "condition",
        .effect = "effect",
        .principal = "principal",
        .resource = "resource",
    };
};
