const PrivateNetworkAccess = @import("private_network_access.zig").PrivateNetworkAccess;

/// Specifies how AWS DevOps Agent reaches your application using a Release
/// Management Environment
pub const NetworkAccessConfiguration = union(enum) {
    /// Private network access to the resource inside a VPC, using a private
    /// connection.
    private_access: ?PrivateNetworkAccess,

    pub const json_field_names = .{
        .private_access = "privateAccess",
    };
};
