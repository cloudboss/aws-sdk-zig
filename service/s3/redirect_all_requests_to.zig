const Protocol = @import("protocol.zig").Protocol;

/// Specifies the redirect behavior of all requests to a website endpoint of an
/// Amazon S3 bucket.
pub const RedirectAllRequestsTo = struct {
    /// Name of the host where requests are redirected.
    host_name: []const u8,

    /// Protocol to use when redirecting requests. The default is the protocol that
    /// is used in the original
    /// request.
    protocol: ?Protocol = null,
};
