/// Information about a health check.
pub const HealthCheck = struct {
    /// The number of consecutive health checks successes required before moving the
    /// instance to the `Healthy` state.
    healthy_threshold: i32,

    /// The approximate interval, in seconds, between health checks of an individual
    /// instance.
    interval: i32,

    /// The instance being checked. The protocol is either TCP, HTTP, HTTPS, or SSL.
    /// The range of valid ports is one (1) through 65535.
    ///
    /// TCP is the default, specified as a TCP: port pair, for example "TCP:5000".
    /// In this case, a health check simply attempts to open a TCP connection to the
    /// instance on the specified port. Failure to connect within the configured
    /// timeout is considered unhealthy.
    ///
    /// SSL is also specified as SSL: port pair, for example, SSL:5000.
    ///
    /// For HTTP/HTTPS, you must include a ping path in the string. HTTP is
    /// specified as a HTTP:port;/;PathToPing; grouping, for example
    /// "HTTP:80/weather/us/wa/seattle". In this case, a HTTP GET request is issued
    /// to the instance on the given port and path. Any answer other than "200 OK"
    /// within the timeout period is considered unhealthy.
    ///
    /// The total length of the HTTP ping target must be 1024 16-bit Unicode
    /// characters or less.
    target: []const u8,

    /// The amount of time, in seconds, during which no response means a failed
    /// health check.
    ///
    /// This value must be less than the `Interval` value.
    timeout: i32,

    /// The number of consecutive health check failures required before moving the
    /// instance to the `Unhealthy` state.
    unhealthy_threshold: i32,
};
