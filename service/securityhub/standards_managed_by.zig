/// Provides details about the management of a security standard.
pub const StandardsManagedBy = struct {
    /// An identifier for the company that manages a specific security standard. For
    /// existing
    /// standards, the value is equal to `Amazon Web Services`.
    company: ?[]const u8 = null,

    /// An identifier for the product that manages a specific security standard. For
    /// existing
    /// standards, the value is equal to the Amazon Web Services service that
    /// manages the
    /// standard.
    product: ?[]const u8 = null,

    pub const json_field_names = .{
        .company = "Company",
        .product = "Product",
    };
};
