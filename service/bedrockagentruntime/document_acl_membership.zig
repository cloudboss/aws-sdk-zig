const DocumentAclCondition = @import("document_acl_condition.zig").DocumentAclCondition;
const DocumentAclMemberRelation = @import("document_acl_member_relation.zig").DocumentAclMemberRelation;

/// The membership entry for a document access control list (ACL), containing
/// conditions and their logical relation.
pub const DocumentAclMembership = struct {
    /// The list of conditions that determine membership.
    conditions: ?[]const DocumentAclCondition = null,

    /// The logical relation between conditions. Valid values: `AND` – All
    /// conditions must match. `OR` – At least one condition must match.
    member_relation: ?DocumentAclMemberRelation = null,

    pub const json_field_names = .{
        .conditions = "conditions",
        .member_relation = "memberRelation",
    };
};
