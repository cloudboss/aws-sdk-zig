const CollaborationChangeSpecification = @import("collaboration_change_specification.zig").CollaborationChangeSpecification;
const MemberChangeSpecification = @import("member_change_specification.zig").MemberChangeSpecification;

/// A union that contains the specification details for different types of
/// changes.
pub const ChangeSpecification = union(enum) {
    /// The collaboration configuration changes being requested. Currently, this
    /// only supports modifying which change types are auto-approved for the
    /// collaboration.
    collaboration: ?CollaborationChangeSpecification,
    /// The member change specification when the change type is `MEMBER`.
    member: ?MemberChangeSpecification,

    pub const json_field_names = .{
        .collaboration = "collaboration",
        .member = "member",
    };
};
