const Type = @import("type.zig").Type;

/// Container for the person being granted permissions.
pub const Grantee = struct {
    display_name: ?[]const u8,

    email_address: ?[]const u8,

    /// The canonical user ID of the grantee.
    id: ?[]const u8,

    /// Type of grantee
    @"type": Type,

    /// URI of the grantee group.
    uri: ?[]const u8,
};
