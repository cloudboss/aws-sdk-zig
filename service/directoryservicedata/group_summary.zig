const GroupScope = @import("group_scope.zig").GroupScope;
const GroupType = @import("group_type.zig").GroupType;

/// A structure containing a subset of fields of a group object from a
/// directory.
pub const GroupSummary = struct {
    /// The scope of the AD group. For details, see [Active Directory security
    /// groups](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).
    group_scope: GroupScope,

    /// The AD group type. For details, see [Active Directory security group
    /// type](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#how-active-directory-security-groups-work).
    group_type: GroupType,

    /// The name of the group.
    sam_account_name: []const u8,

    /// The unique security identifier (SID) of the group.
    sid: []const u8,

    pub const json_field_names = .{
        .group_scope = "GroupScope",
        .group_type = "GroupType",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
    };
};
