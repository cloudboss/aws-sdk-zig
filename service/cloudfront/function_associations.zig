const FunctionAssociation = @import("function_association.zig").FunctionAssociation;

/// A list of CloudFront functions that are associated with a cache behavior in
/// a CloudFront distribution. Your functions must be published to the `LIVE`
/// stage to associate them with a cache behavior.
pub const FunctionAssociations = struct {
    /// The CloudFront functions that are associated with a cache behavior in a
    /// CloudFront distribution. Your functions must be published to the `LIVE`
    /// stage to associate them with a cache behavior.
    items: ?[]const FunctionAssociation = null,

    /// The number of CloudFront functions in the list.
    quantity: i32,
};
