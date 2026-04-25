/// Indicates default conntrack information for the instance type. For more
/// information, see
/// [ Connection tracking timeouts
/// ](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts) in the Amazon EC2 User Guide.
pub const DefaultConnectionTrackingConfiguration = struct {
    /// Default timeout (in seconds) for idle TCP connections in an established
    /// state.
    default_tcp_established_timeout: ?i32 = null,

    /// Default timeout (in seconds) for idle UDP flows classified as streams which
    /// have seen more than one request-response transaction.
    default_udp_stream_timeout: ?i32 = null,

    /// Default timeout (in seconds) for idle UDP flows that have seen traffic only
    /// in a single direction or a single request-response transaction.
    default_udp_timeout: ?i32 = null,
};
