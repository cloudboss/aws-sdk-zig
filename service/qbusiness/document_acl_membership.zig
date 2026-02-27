const DocumentAclCondition = @import("document_acl_condition.zig").DocumentAclCondition;
const MemberRelation = @import("member_relation.zig").MemberRelation;

/// Represents membership rules in the document's ACL, defining how users or
/// groups are associated with access permissions.
pub const DocumentAclMembership = struct {
    /// An array of conditions that define the membership rules. Each condition
    /// specifies criteria for users or groups to be included in this membership.
    conditions: ?[]const DocumentAclCondition,

    /// The logical relation between members in the membership rule, determining how
    /// multiple conditions are combined.
    member_relation: ?MemberRelation,

    pub const json_field_names = .{
        .conditions = "conditions",
        .member_relation = "memberRelation",
    };
};
