const StatusCodes = @import("status_codes.zig").StatusCodes;

/// A complex data type that includes information about the failover criteria
/// for an origin group, including the status codes for which CloudFront will
/// failover from the primary origin to the second origin.
pub const OriginGroupFailoverCriteria = struct {
    /// The status codes that, when returned from the primary origin, will trigger
    /// CloudFront to failover to the second origin.
    status_codes: StatusCodes,
};
