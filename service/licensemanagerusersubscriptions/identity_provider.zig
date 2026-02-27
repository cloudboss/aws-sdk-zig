const ActiveDirectoryIdentityProvider = @import("active_directory_identity_provider.zig").ActiveDirectoryIdentityProvider;

/// Refers to an identity provider.
pub const IdentityProvider = union(enum) {
    /// The `ActiveDirectoryIdentityProvider` resource contains settings and other
    /// details about a specific Active Directory identity provider.
    active_directory_identity_provider: ?ActiveDirectoryIdentityProvider,

    pub const json_field_names = .{
        .active_directory_identity_provider = "ActiveDirectoryIdentityProvider",
    };
};
