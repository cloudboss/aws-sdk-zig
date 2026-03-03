const CustomErrorResponse = @import("custom_error_response.zig").CustomErrorResponse;

/// A complex type that controls:
///
/// * Whether CloudFront replaces HTTP status codes in the 4xx and 5xx range
///   with custom error messages before returning the response to the viewer.
/// * How long CloudFront caches HTTP status codes in the 4xx and 5xx range.
///
/// For more information about custom error pages, see [Customizing Error
/// Responses](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html) in the *Amazon CloudFront Developer Guide*.
pub const CustomErrorResponses = struct {
    /// A complex type that contains a `CustomErrorResponse` element for each HTTP
    /// status code for which you want to specify a custom error page and/or a
    /// caching duration.
    items: ?[]const CustomErrorResponse = null,

    /// The number of HTTP status codes for which you want to specify a custom error
    /// page and/or a caching duration. If `Quantity` is `0`, you can omit `Items`.
    quantity: i32,
};
