const UserDesignation = @import("user_designation.zig").UserDesignation;
const Member = @import("member.zig").Member;

/// A map of user or group profiles to designations that need to be assigned in
/// the project.
pub const ProjectMembershipAssignment = struct {
    /// The designation of the project membership.
    designation: UserDesignation,

    /// The details about a project member.
    member: Member,

    pub const json_field_names = .{
        .designation = "designation",
        .member = "member",
    };
};
