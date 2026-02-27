pub const GrpcRetryPolicyEvent = enum {
    cancelled,
    deadline_exceeded,
    internal,
    resource_exhausted,
    unavailable,

    pub const json_field_names = .{
        .cancelled = "CANCELLED",
        .deadline_exceeded = "DEADLINE_EXCEEDED",
        .internal = "INTERNAL",
        .resource_exhausted = "RESOURCE_EXHAUSTED",
        .unavailable = "UNAVAILABLE",
    };
};
