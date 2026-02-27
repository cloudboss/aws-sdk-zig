const Paths = @import("paths.zig").Paths;

/// An invalidation batch.
pub const InvalidationBatch = struct {
    /// A value that you specify to uniquely identify an invalidation request.
    /// CloudFront uses the value to prevent you from accidentally resubmitting an
    /// identical request. Whenever you create a new invalidation request, you must
    /// specify a new value for `CallerReference` and change other values in the
    /// request as applicable. One way to ensure that the value of `CallerReference`
    /// is unique is to use a `timestamp`, for example, `20120301090000`.
    ///
    /// If you make a second invalidation request with the same value for
    /// `CallerReference`, and if the rest of the request is the same, CloudFront
    /// doesn't create a new invalidation request. Instead, CloudFront returns
    /// information about the invalidation request that you previously created with
    /// the same `CallerReference`.
    ///
    /// If `CallerReference` is a value you already sent in a previous invalidation
    /// batch request but the content of any `Path` is different from the original
    /// request, CloudFront returns an `InvalidationBatchAlreadyExists` error.
    caller_reference: []const u8,

    /// A complex type that contains information about the objects that you want to
    /// invalidate. For more information, see [Specifying the Objects to
    /// Invalidate](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html#invalidation-specifying-objects) in the *Amazon CloudFront Developer Guide*.
    paths: Paths,
};
