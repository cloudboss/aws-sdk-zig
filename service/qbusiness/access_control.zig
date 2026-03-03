const MemberRelation = @import("member_relation.zig").MemberRelation;
const Principal = @import("principal.zig").Principal;

/// A list of principals. Each principal can be either a `USER` or a `GROUP` and
/// can be designated document access permissions of either `ALLOW` or `DENY`.
pub const AccessControl = struct {
    /// Describes the member relation within a principal list.
    member_relation: ?MemberRelation = null,

    /// Contains a list of principals, where a principal can be either a `USER` or a
    /// `GROUP`. Each principal can be have the following type of document access:
    /// `ALLOW` or `DENY`.
    principals: []const Principal,

    pub const json_field_names = .{
        .member_relation = "memberRelation",
        .principals = "principals",
    };
};
