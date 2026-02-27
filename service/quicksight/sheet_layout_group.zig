const SheetLayoutGroupMember = @import("sheet_layout_group_member.zig").SheetLayoutGroupMember;

/// A group of elements within a sheet layout.
pub const SheetLayoutGroup = struct {
    /// A unique identifier for the group.
    id: []const u8,

    /// The members of the group.
    members: []const SheetLayoutGroupMember,

    pub const json_field_names = .{
        .id = "Id",
        .members = "Members",
    };
};
