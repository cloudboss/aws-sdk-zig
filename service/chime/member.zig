const MemberType = @import("member_type.zig").MemberType;

/// The member details, such as email address, name, member ID, and member type.
pub const Member = struct {
    /// The Amazon Chime account ID.
    account_id: ?[]const u8,

    /// The member email address.
    email: ?[]const u8,

    /// The member name.
    full_name: ?[]const u8,

    /// The member ID (user ID or bot ID).
    member_id: ?[]const u8,

    /// The member type.
    member_type: ?MemberType,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .email = "Email",
        .full_name = "FullName",
        .member_id = "MemberId",
        .member_type = "MemberType",
    };
};
