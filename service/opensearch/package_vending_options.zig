/// Configuration options for determining whether a package can be made
/// available for use
/// by other users.
pub const PackageVendingOptions = struct {
    /// Indicates whether the package vending feature is enabled, allowing the
    /// package to be
    /// used by other users.
    vending_enabled: bool,

    pub const json_field_names = .{
        .vending_enabled = "VendingEnabled",
    };
};
