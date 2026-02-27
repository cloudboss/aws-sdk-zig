/// A complex data type for the status codes that you specify that, when
/// returned by a primary origin, trigger CloudFront to failover to a second
/// origin.
pub const StatusCodes = struct {
    /// The items (status codes) for an origin group.
    items: []const i32,

    /// The number of status codes.
    quantity: i32,
};
