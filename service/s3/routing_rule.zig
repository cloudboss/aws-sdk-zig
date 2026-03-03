const Condition = @import("condition.zig").Condition;
const Redirect = @import("redirect.zig").Redirect;

/// Specifies the redirect behavior and when a redirect is applied. For more
/// information about routing
/// rules, see [Configuring
/// advanced conditional
/// redirects](https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html#advanced-conditional-redirects) in the *Amazon S3 User Guide*.
pub const RoutingRule = struct {
    /// A container for describing a condition that must be met for the specified
    /// redirect to apply. For
    /// example, 1. If request is for pages in the `/docs` folder, redirect to the
    /// `/documents` folder. 2. If request results in HTTP error 4xx, redirect
    /// request to another
    /// host where you might process the error.
    condition: ?Condition = null,

    /// Container for redirect information. You can redirect requests to another
    /// host, to another page, or
    /// with another protocol. In the event of an error, you can specify a different
    /// error code to
    /// return.
    redirect: Redirect,
};
