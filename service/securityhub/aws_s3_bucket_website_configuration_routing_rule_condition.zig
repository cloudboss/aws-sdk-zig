/// The condition that must be met in order to apply the routing rule.
pub const AwsS3BucketWebsiteConfigurationRoutingRuleCondition = struct {
    /// Indicates to redirect the request if the HTTP error code matches this value.
    http_error_code_returned_equals: ?[]const u8,

    /// Indicates to redirect the request if the key prefix matches this value.
    key_prefix_equals: ?[]const u8,

    pub const json_field_names = .{
        .http_error_code_returned_equals = "HttpErrorCodeReturnedEquals",
        .key_prefix_equals = "KeyPrefixEquals",
    };
};
