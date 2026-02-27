const ResponseHeadersPolicyAccessControlAllowMethodsValues = @import("response_headers_policy_access_control_allow_methods_values.zig").ResponseHeadersPolicyAccessControlAllowMethodsValues;

/// A list of HTTP methods that CloudFront includes as values for the
/// `Access-Control-Allow-Methods` HTTP response header.
///
/// For more information about the `Access-Control-Allow-Methods` HTTP response
/// header, see
/// [Access-Control-Allow-Methods](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods) in the MDN Web Docs.
pub const ResponseHeadersPolicyAccessControlAllowMethods = struct {
    /// The list of HTTP methods. Valid values are:
    ///
    /// * `GET`
    /// * `DELETE`
    /// * `HEAD`
    /// * `OPTIONS`
    /// * `PATCH`
    /// * `POST`
    /// * `PUT`
    /// * `ALL`
    ///
    /// `ALL` is a special value that includes all of the listed HTTP methods.
    items: []const ResponseHeadersPolicyAccessControlAllowMethodsValues,

    /// The number of HTTP methods in the list.
    quantity: i32,
};
