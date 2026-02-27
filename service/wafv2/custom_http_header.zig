/// A custom header for custom request and response handling. This is used in
/// CustomResponse and CustomRequestHandling.
pub const CustomHTTPHeader = struct {
    /// The name of the custom header.
    ///
    /// For custom request header insertion, when WAF inserts the header into the
    /// request,
    /// it prefixes this name `x-amzn-waf-`, to avoid confusion with the headers
    /// that
    /// are already in the request. For example, for the header name `sample`, WAF
    /// inserts the header `x-amzn-waf-sample`.
    name: []const u8,

    /// The value of the custom header.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
