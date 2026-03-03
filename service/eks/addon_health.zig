const AddonIssue = @import("addon_issue.zig").AddonIssue;

/// The health of the add-on.
pub const AddonHealth = struct {
    /// An object representing the health issues for an add-on.
    issues: ?[]const AddonIssue = null,

    pub const json_field_names = .{
        .issues = "issues",
    };
};
