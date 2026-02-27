/// Describes the sign-in credentials for the container image registry of an
/// Amazon Lightsail
/// account.
pub const ContainerServiceRegistryLogin = struct {
    /// The timestamp of when the container image registry sign-in credentials
    /// expire.
    ///
    /// The log in credentials expire 12 hours after they are created, at which
    /// point you will
    /// need to create a new set of log in credentials using the
    /// `CreateContainerServiceRegistryLogin` action.
    expires_at: ?i64,

    /// The container service registry password to use to push container images to
    /// the container
    /// image registry of a Lightsail account
    password: ?[]const u8,

    /// The address to use to push container images to the container image registry
    /// of a
    /// Lightsail account.
    registry: ?[]const u8,

    /// The container service registry username to use to push container images to
    /// the container
    /// image registry of a Lightsail account.
    username: ?[]const u8,

    pub const json_field_names = .{
        .expires_at = "expiresAt",
        .password = "password",
        .registry = "registry",
        .username = "username",
    };
};
