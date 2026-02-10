/// A security group connection tracking specification response that enables you
/// to set
/// the idle timeout for connection tracking on an Elastic network interface.
/// For more
/// information, see [Connection tracking
/// timeouts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts) in the
/// *Amazon EC2 User Guide*.
pub const ConnectionTrackingSpecificationResponse = struct {
    /// Timeout (in seconds) for idle TCP
    /// connections in an established state. Min: 60 seconds. Max: 432000 seconds (5
    /// days). Default: 432000 seconds. Recommended: Less than 432000 seconds.
    tcp_established_timeout: ?i32,

    /// Timeout (in seconds) for idle UDP
    /// flows classified as streams which have seen more than one request-response
    /// transaction. Min: 60 seconds. Max: 180 seconds (3 minutes). Default: 180
    /// seconds.
    udp_stream_timeout: ?i32,

    /// Timeout (in seconds) for idle UDP flows that
    /// have seen traffic only in a single direction or a single request-response
    /// transaction. Min: 30 seconds. Max: 60 seconds. Default: 30 seconds.
    udp_timeout: ?i32,
};
