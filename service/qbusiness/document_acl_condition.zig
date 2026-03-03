const DocumentAclGroup = @import("document_acl_group.zig").DocumentAclGroup;
const MemberRelation = @import("member_relation.zig").MemberRelation;
const DocumentAclUser = @import("document_acl_user.zig").DocumentAclUser;

/// Represents a condition in the document's ACL, specifying access rules for
/// users and groups.
pub const DocumentAclCondition = struct {
    /// An array of group identifiers that this condition applies to. Groups listed
    /// here are subject to the access rule defined by this condition.
    groups: ?[]const DocumentAclGroup = null,

    /// The logical relation between members in the condition, determining how
    /// multiple user or group conditions are combined.
    member_relation: ?MemberRelation = null,

    /// An array of user identifiers that this condition applies to. Users listed
    /// here are subject to the access rule defined by this condition.
    users: ?[]const DocumentAclUser = null,

    pub const json_field_names = .{
        .groups = "groups",
        .member_relation = "memberRelation",
        .users = "users",
    };
};
