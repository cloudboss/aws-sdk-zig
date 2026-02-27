/// A complex type that contains information about the objects that you want to
/// invalidate. For more information, see [Specifying the Objects to
/// Invalidate](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html#invalidation-specifying-objects) in the *Amazon CloudFront Developer Guide*.
pub const Paths = struct {
    /// A complex type that contains a list of the paths that you want to
    /// invalidate.
    items: ?[]const []const u8,

    /// The number of invalidation paths specified for the objects that you want to
    /// invalidate.
    quantity: i32,
};
