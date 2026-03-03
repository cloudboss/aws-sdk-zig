const RedirectActionStatusCodeEnum = @import("redirect_action_status_code_enum.zig").RedirectActionStatusCodeEnum;

/// Information about a redirect action.
///
/// A URI consists of the following components:
/// protocol://hostname:port/path?query. You must
/// modify at least one of the following components to avoid a redirect loop:
/// protocol, hostname,
/// port, or path. Any components that you do not modify retain their original
/// values.
///
/// You can reuse URI components using the following reserved keywords:
///
/// * #{protocol}
///
/// * #{host}
///
/// * #{port}
///
/// * #{path} (the leading "/" is removed)
///
/// * #{query}
///
/// For example, you can change the path to "/new/#{path}", the hostname to
/// "example.#{host}",
/// or the query to "#{query}&value=xyz".
pub const RedirectActionConfig = struct {
    /// The hostname. This component is not percent-encoded. The hostname can
    /// contain
    /// #{host}.
    host: ?[]const u8 = null,

    /// The absolute path, starting with the leading "/". This component is not
    /// percent-encoded.
    /// The path can contain #{host}, #{path}, and #{port}.
    path: ?[]const u8 = null,

    /// The port. You can specify a value from 1 to 65535 or #{port}.
    port: ?[]const u8 = null,

    /// The protocol. You can specify HTTP, HTTPS, or #{protocol}. You can redirect
    /// HTTP to HTTP,
    /// HTTP to HTTPS, and HTTPS to HTTPS. You can't redirect HTTPS to HTTP.
    protocol: ?[]const u8 = null,

    /// The query parameters, URL-encoded when necessary, but not percent-encoded.
    /// Do not include
    /// the leading "?", as it is automatically added. You can specify any of the
    /// reserved
    /// keywords.
    query: ?[]const u8 = null,

    /// The HTTP redirect code. The redirect is either permanent (HTTP 301) or
    /// temporary (HTTP
    /// 302).
    status_code: RedirectActionStatusCodeEnum,
};
