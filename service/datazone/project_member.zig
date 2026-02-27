const UserDesignation = @import("user_designation.zig").UserDesignation;
const MemberDetails = @import("member_details.zig").MemberDetails;

/// The details of a project member.
pub const ProjectMember = struct {
    /// The designated role of a project member.
    designation: UserDesignation,

    /// The membership details of a project member.
    member_details: MemberDetails,

    pub const json_field_names = .{
        .designation = "designation",
        .member_details = "memberDetails",
    };
};
