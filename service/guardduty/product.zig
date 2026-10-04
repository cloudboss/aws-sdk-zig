/// Contains information about the product that produced an investigation.
pub const Product = struct {
    /// The specific feature within the product that produced the investigation.
    feature: ?[]const u8 = null,

    /// The name of the product.
    name: []const u8,

    pub const json_field_names = .{
        .feature = "Feature",
        .name = "Name",
    };
};
