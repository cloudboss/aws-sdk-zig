const EventType = @import("event_type.zig").EventType;

/// A CloudFront function that is associated with a cache behavior in a
/// CloudFront distribution.
pub const FunctionAssociation = struct {
    /// The event type of the function, either `viewer-request` or
    /// `viewer-response`. You cannot use origin-facing event types
    /// (`origin-request` and `origin-response`) with a CloudFront function.
    event_type: EventType,

    /// The Amazon Resource Name (ARN) of the function.
    function_arn: []const u8,
};
