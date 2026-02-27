const MemberGroup = @import("member_group.zig").MemberGroup;
const MemberUser = @import("member_user.zig").MemberUser;
const S3 = @import("s3.zig").S3;

/// A list of users or sub groups that belong to a group. This is for generating
/// Amazon Q Business chat results only from document a user has access to.
pub const GroupMembers = struct {
    /// A list of sub groups that belong to a group. For example, the sub groups
    /// "Research", "Engineering", and "Sales and Marketing" all belong to the group
    /// "Company".
    member_groups: ?[]const MemberGroup,

    /// A list of users that belong to a group. For example, a list of interns all
    /// belong to the "Interns" group.
    member_users: ?[]const MemberUser,

    s_3_path_for_group_members: ?S3,

    pub const json_field_names = .{
        .member_groups = "memberGroups",
        .member_users = "memberUsers",
        .s_3_path_for_group_members = "s3PathForGroupMembers",
    };
};
