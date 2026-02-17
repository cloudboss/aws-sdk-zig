const ErrorDocument = @import("error_document.zig").ErrorDocument;
const IndexDocument = @import("index_document.zig").IndexDocument;
const RedirectAllRequestsTo = @import("redirect_all_requests_to.zig").RedirectAllRequestsTo;
const RoutingRule = @import("routing_rule.zig").RoutingRule;

/// Specifies website configuration parameters for an Amazon S3 bucket.
pub const WebsiteConfiguration = struct {
    /// The name of the error document for the website.
    error_document: ?ErrorDocument,

    /// The name of the index document for the website.
    index_document: ?IndexDocument,

    /// The redirect behavior for every request to this bucket's website endpoint.
    ///
    /// If you specify this property, you can't specify any other property.
    redirect_all_requests_to: ?RedirectAllRequestsTo,

    /// Rules that define when a redirect is applied and the redirect behavior.
    routing_rules: ?[]const RoutingRule,
};
