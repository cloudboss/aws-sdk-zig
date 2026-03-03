const Type = @import("type.zig").Type;

/// Container for the person being granted permissions.
pub const Grantee = struct {
    display_name: ?[]const u8 = null,

    email_address: ?[]const u8 = null,

    /// The canonical user ID of the grantee.
    id: ?[]const u8 = null,

    /// Type of grantee
    @"type": Type,

    /// URI of the grantee group.
    uri: ?[]const u8 = null,
};
