pub const InvalidParameterProblem = enum {
    /// The parameter was corrupted and could not be understood by the service.
    corrupted,
    /// The parameter was expired and can no longer be used.
    expired,
    /// The client called the service before the time specified in the poll
    /// interval.
    poll_interval_not_satisfied,

    pub const json_field_names = .{
        .corrupted = "CORRUPTED",
        .expired = "EXPIRED",
        .poll_interval_not_satisfied = "POLL_INTERVAL_NOT_SATISFIED",
    };
};
