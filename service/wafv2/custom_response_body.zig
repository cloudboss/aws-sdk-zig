const ResponseContentType = @import("response_content_type.zig").ResponseContentType;

/// The response body to use in a custom response to a web request. This is
/// referenced by
/// key from CustomResponse
/// `CustomResponseBodyKey`.
pub const CustomResponseBody = struct {
    /// The payload of the custom response.
    ///
    /// You can use JSON escape strings in JSON content. To do this, you must
    /// specify JSON
    /// content in the `ContentType` setting.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    content: []const u8,

    /// The type of content in the payload that you are defining in the `Content`
    /// string.
    content_type: ResponseContentType,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
    };
};
