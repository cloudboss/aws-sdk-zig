const AwsWafv2CustomHttpHeader = @import("aws_wafv_2_custom_http_header.zig").AwsWafv2CustomHttpHeader;

/// Custom request handling behavior that inserts custom headers into a web
/// request. WAF uses custom request handling when the rule action doesn't block
/// the request.
pub const AwsWafv2CustomRequestHandlingDetails = struct {
    /// The HTTP headers to insert into the request.
    insert_headers: ?[]const AwsWafv2CustomHttpHeader = null,

    pub const json_field_names = .{
        .insert_headers = "InsertHeaders",
    };
};
