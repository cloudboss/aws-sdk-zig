const AwsS3BucketWebsiteConfigurationRedirectTo = @import("aws_s3_bucket_website_configuration_redirect_to.zig").AwsS3BucketWebsiteConfigurationRedirectTo;
const AwsS3BucketWebsiteConfigurationRoutingRule = @import("aws_s3_bucket_website_configuration_routing_rule.zig").AwsS3BucketWebsiteConfigurationRoutingRule;

/// Website parameters for the S3
/// bucket.
pub const AwsS3BucketWebsiteConfiguration = struct {
    /// The name of the error document for the website.
    error_document: ?[]const u8,

    /// The name of the index document for the website.
    index_document_suffix: ?[]const u8,

    /// The redirect behavior for requests to the website.
    redirect_all_requests_to: ?AwsS3BucketWebsiteConfigurationRedirectTo,

    /// The rules for applying redirects for requests to the website.
    routing_rules: ?[]const AwsS3BucketWebsiteConfigurationRoutingRule,

    pub const json_field_names = .{
        .error_document = "ErrorDocument",
        .index_document_suffix = "IndexDocumentSuffix",
        .redirect_all_requests_to = "RedirectAllRequestsTo",
        .routing_rules = "RoutingRules",
    };
};
