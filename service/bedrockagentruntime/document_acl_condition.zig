const DocumentAclMemberRelation = @import("document_acl_member_relation.zig").DocumentAclMemberRelation;
const DocumentAclGroup = @import("document_acl_group.zig").DocumentAclGroup;
const DocumentAclUser = @import("document_acl_user.zig").DocumentAclUser;

/// A condition within a document access control list (ACL) membership,
/// specifying users and groups that are evaluated together.
pub const DocumentAclCondition = struct {
    /// The logical operator for combining users and groups within this condition.
    /// Valid values: `AND` – Both a user match and a group match are required. `OR`
    /// – Either a user match or a group match is sufficient.
    condition_operator: ?DocumentAclMemberRelation = null,

    /// The list of group entries in this condition.
    groups: ?[]const DocumentAclGroup = null,

    /// The list of user entries in this condition.
    users: ?[]const DocumentAclUser = null,

    pub const json_field_names = .{
        .condition_operator = "conditionOperator",
        .groups = "groups",
        .users = "users",
    };
};
