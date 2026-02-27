/// Represents the percentage of requests over the last 10 seconds that resulted
/// in each
/// type of status code response. For more information, see [Status Code
/// Definitions](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).
pub const StatusCodes = struct {
    /// The percentage of requests over the last 10 seconds that resulted in a 2xx
    /// (200, 201,
    /// etc.) status code.
    status_2_xx: ?i32,

    /// The percentage of requests over the last 10 seconds that resulted in a 3xx
    /// (300, 301,
    /// etc.) status code.
    status_3_xx: ?i32,

    /// The percentage of requests over the last 10 seconds that resulted in a 4xx
    /// (400, 401,
    /// etc.) status code.
    status_4_xx: ?i32,

    /// The percentage of requests over the last 10 seconds that resulted in a 5xx
    /// (500, 501,
    /// etc.) status code.
    status_5_xx: ?i32,
};
