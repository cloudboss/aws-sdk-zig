const BlockerType = @import("blocker_type.zig").BlockerType;

/// Reserved for future use.
pub const BlockerDeclaration = struct {
    /// Reserved for future use.
    name: []const u8,

    /// Reserved for future use.
    type: BlockerType,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
