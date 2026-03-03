const MemberType = @import("member_type.zig").MemberType;

/// An asset in a Quick Sight folder, such as a dashboard, analysis, or dataset.
pub const FolderMember = struct {
    /// The ID of an asset in the folder.
    member_id: ?[]const u8 = null,

    /// The type of asset that it is.
    member_type: ?MemberType = null,

    pub const json_field_names = .{
        .member_id = "MemberId",
        .member_type = "MemberType",
    };
};
