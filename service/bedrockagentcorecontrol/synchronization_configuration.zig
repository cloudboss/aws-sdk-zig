const FromUrlSynchronizationConfiguration = @import("from_url_synchronization_configuration.zig").FromUrlSynchronizationConfiguration;

/// Configuration for synchronizing registry record metadata from an external
/// source.
pub const SynchronizationConfiguration = struct {
    /// Configuration for synchronizing from a URL-based source.
    from_url: ?FromUrlSynchronizationConfiguration = null,

    pub const json_field_names = .{
        .from_url = "fromUrl",
    };
};
