const UserType = @import("user_type.zig").UserType;

/// A structure that specifies one user or group in the workspace.
pub const User = struct {
    /// The ID of the user or group.
    ///
    /// Pattern:
    /// `^([0-9a-fA-F]{10}-|)[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}$`
    id: []const u8,

    /// Specifies whether this is a single user or a group.
    @"type": UserType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};
