const LFTag = @import("lf_tag.zig").LFTag;
const DatabaseLFTagPolicyPermission = @import("database_lf_tag_policy_permission.zig").DatabaseLFTagPolicyPermission;

/// The LF-tag policy and permissions for database resources.
pub const DatabaseLFTagPolicyAndPermissions = struct {
    /// A list of LF-tag conditions that apply to database resources.
    expression: []const LFTag,

    /// The permissions granted to subscribers on database resources.
    permissions: []const DatabaseLFTagPolicyPermission,

    pub const json_field_names = .{
        .expression = "Expression",
        .permissions = "Permissions",
    };
};
