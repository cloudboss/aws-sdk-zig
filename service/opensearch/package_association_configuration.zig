const KeyStoreAccessOption = @import("key_store_access_option.zig").KeyStoreAccessOption;

/// The configuration for associating a package with a domain.
pub const PackageAssociationConfiguration = struct {
    /// The configuration parameters to enable accessing the key store required by
    /// the
    /// package.
    key_store_access_option: ?KeyStoreAccessOption,

    pub const json_field_names = .{
        .key_store_access_option = "KeyStoreAccessOption",
    };
};
