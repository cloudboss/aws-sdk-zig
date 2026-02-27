const MemberGroup = @import("member_group.zig").MemberGroup;
const MemberUser = @import("member_user.zig").MemberUser;
const S3Path = @import("s3_path.zig").S3Path;

/// A list of users that belong to a group. This is useful for user context
/// filtering, where search results are filtered based on the user or their
/// group access to
/// documents.
pub const GroupMembers = struct {
    /// A list of users that belong to a group. This can also include sub groups.
    /// For example,
    /// the sub groups "Research", "Engineering", and "Sales and Marketing" all
    /// belong to the group
    /// "Company A".
    member_groups: ?[]const MemberGroup,

    /// A list of users that belong to a group. For example, a list of interns all
    /// belong to
    /// the "Interns" group.
    member_users: ?[]const MemberUser,

    /// If you have more than 1000 users and/or sub groups for a single group, you
    /// need to
    /// provide the path to the S3 file that lists your users and sub groups for a
    /// group. Your
    /// sub groups can contain more than 1000 users, but the list of sub groups that
    /// belong to a
    /// group (and/or users) must be no more than 1000.
    ///
    /// You can download this [example
    /// S3
    /// file](https://docs.aws.amazon.com/kendra/latest/dg/samples/group_members.zip) that uses the correct format for listing group members. Note,
    /// `dataSourceId` is optional. The value of `type` for a group is
    /// always `GROUP` and for a user it is always `USER`.
    s3_pathfor_group_members: ?S3Path,

    pub const json_field_names = .{
        .member_groups = "MemberGroups",
        .member_users = "MemberUsers",
        .s3_pathfor_group_members = "S3PathforGroupMembers",
    };
};
