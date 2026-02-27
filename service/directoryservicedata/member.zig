const MemberType = @import("member_type.zig").MemberType;

/// A member object that contains identifying information for a specified
/// member.
pub const Member = struct {
    /// The AD type of the member object.
    member_type: MemberType,

    /// The name of the group member.
    sam_account_name: []const u8,

    /// The unique security identifier (SID) of the group member.
    sid: []const u8,

    pub const json_field_names = .{
        .member_type = "MemberType",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
    };
};
