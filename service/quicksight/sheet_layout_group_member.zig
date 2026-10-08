const SheetLayoutGroupMemberType = @import("sheet_layout_group_member_type.zig").SheetLayoutGroupMemberType;

/// A member of a sheet layout group.
pub const SheetLayoutGroupMember = struct {
    /// The unique identifier of the group member.
    id: []const u8,

    /// The type of the group member.
    type: SheetLayoutGroupMemberType,

    pub const json_field_names = .{
        .id = "Id",
        .type = "Type",
    };
};
