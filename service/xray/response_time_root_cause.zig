const ResponseTimeRootCauseService = @import("response_time_root_cause_service.zig").ResponseTimeRootCauseService;

/// The root cause information for a response time warning.
pub const ResponseTimeRootCause = struct {
    /// A flag that denotes that the root cause impacts the trace client.
    client_impacting: ?bool,

    /// A list of corresponding services. A service identifies a segment and
    /// contains a name,
    /// account ID, type, and inferred flag.
    services: ?[]const ResponseTimeRootCauseService,

    pub const json_field_names = .{
        .client_impacting = "ClientImpacting",
        .services = "Services",
    };
};
