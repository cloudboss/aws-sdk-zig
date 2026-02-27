const LFTag = @import("lf_tag.zig").LFTag;
const TableTagPolicyLFPermission = @import("table_tag_policy_lf_permission.zig").TableTagPolicyLFPermission;

/// The LF-tag policy and permissions that apply to table resources.
pub const TableLFTagPolicyAndPermissions = struct {
    /// A list of LF-tag conditions that apply to table resources.
    expression: []const LFTag,

    /// The permissions granted to subscribers on table resources.
    permissions: []const TableTagPolicyLFPermission,

    pub const json_field_names = .{
        .expression = "Expression",
        .permissions = "Permissions",
    };
};
