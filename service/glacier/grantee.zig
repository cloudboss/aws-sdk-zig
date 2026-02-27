const Type = @import("type.zig").Type;

/// Contains information about the grantee.
pub const Grantee = struct {
    /// Screen name of the grantee.
    display_name: ?[]const u8,

    /// Email address of the grantee.
    email_address: ?[]const u8,

    /// The canonical user ID of the grantee.
    id: ?[]const u8,

    /// Type of grantee
    type: Type,

    /// URI of the grantee group.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .email_address = "EmailAddress",
        .id = "ID",
        .type = "Type",
        .uri = "URI",
    };
};
