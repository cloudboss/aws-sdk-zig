const FrameOptionsList = @import("frame_options_list.zig").FrameOptionsList;

/// Determines whether CloudFront includes the `X-Frame-Options` HTTP response
/// header and the header's value.
///
/// For more information about the `X-Frame-Options` HTTP response header, see
/// [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) in the MDN Web Docs.
pub const ResponseHeadersPolicyFrameOptions = struct {
    /// The value of the `X-Frame-Options` HTTP response header. Valid values are
    /// `DENY` and `SAMEORIGIN`.
    ///
    /// For more information about these values, see
    /// [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) in the MDN Web Docs.
    frame_option: FrameOptionsList,

    /// A Boolean that determines whether CloudFront overrides the `X-Frame-Options`
    /// HTTP response header received from the origin with the one specified in this
    /// response headers policy.
    override: bool,
};
