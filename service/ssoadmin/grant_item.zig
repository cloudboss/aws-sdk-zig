const Grant = @import("grant.zig").Grant;
const GrantType = @import("grant_type.zig").GrantType;

/// A structure that defines a single grant and its configuration.
pub const GrantItem = struct {
    /// The configuration structure for the selected grant.
    grant: Grant,

    /// The type of the selected grant.
    grant_type: GrantType,

    pub const json_field_names = .{
        .grant = "Grant",
        .grant_type = "GrantType",
    };
};
