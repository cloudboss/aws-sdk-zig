const HeaderEnum = @import("header_enum.zig").HeaderEnum;
const ForwardValues = @import("forward_values.zig").ForwardValues;

/// Describes the request headers that a Lightsail distribution bases caching
/// on.
///
/// For the headers that you specify, your distribution caches separate versions
/// of the
/// specified content based on the header values in viewer requests. For
/// example, suppose viewer
/// requests for `logo.jpg` contain a custom `product` header that has a
/// value of either `acme` or `apex`, and you configure your distribution to
/// cache your content based on values in the `product` header. Your
/// distribution
/// forwards the `product` header to the origin and caches the response from the
/// origin
/// once for each header value.
pub const HeaderObject = struct {
    /// The specific headers to forward to your distribution's origin.
    headers_allow_list: ?[]const HeaderEnum,

    /// The headers that you want your distribution to forward to your origin and
    /// base caching
    /// on.
    ///
    /// You can configure your distribution to do one of the following:
    ///
    /// * **
    /// `all`
    /// ** - Forward all headers to your
    /// origin.
    ///
    /// * **
    /// `none`
    /// ** - Forward only the default
    /// headers.
    ///
    /// * **
    /// `allow-list`
    /// ** - Forward only the headers
    /// you specify using the `headersAllowList` parameter.
    option: ?ForwardValues,

    pub const json_field_names = .{
        .headers_allow_list = "headersAllowList",
        .option = "option",
    };
};
