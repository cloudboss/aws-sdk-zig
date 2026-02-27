const Issue = @import("issue.zig").Issue;

/// An object representing the health status of the node group.
pub const NodegroupHealth = struct {
    /// Any issues that are associated with the node group.
    issues: ?[]const Issue,

    pub const json_field_names = .{
        .issues = "issues",
    };
};
