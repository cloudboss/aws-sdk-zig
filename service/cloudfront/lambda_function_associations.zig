const LambdaFunctionAssociation = @import("lambda_function_association.zig").LambdaFunctionAssociation;

/// A complex type that specifies a list of Lambda@Edge functions associations
/// for a cache behavior.
///
/// If you want to invoke one or more Lambda@Edge functions triggered by
/// requests that match the `PathPattern` of the cache behavior, specify the
/// applicable values for `Quantity` and `Items`. Note that there can be up to 4
/// `LambdaFunctionAssociation` items in this list (one for each possible value
/// of `EventType`) and each `EventType` can be associated with only one
/// function.
///
/// If you don't want to invoke any Lambda@Edge functions for the requests that
/// match `PathPattern`, specify `0` for `Quantity` and omit `Items`.
pub const LambdaFunctionAssociations = struct {
    /// **Optional**: A complex type that contains `LambdaFunctionAssociation` items
    /// for this cache behavior. If `Quantity` is `0`, you can omit `Items`.
    items: ?[]const LambdaFunctionAssociation = null,

    /// The number of Lambda@Edge function associations for this cache behavior.
    quantity: i32,
};
