/// A compute platform.
pub const ComputePlatform = struct {
    /// The compute platform product.
    product: ?[]const u8 = null,

    /// The compute platform vendor.
    vendor: ?[]const u8 = null,

    /// The compute platform version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .product = "product",
        .vendor = "vendor",
        .version = "version",
    };
};
