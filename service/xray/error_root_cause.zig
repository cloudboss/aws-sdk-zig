const ErrorRootCauseService = @import("error_root_cause_service.zig").ErrorRootCauseService;

/// The root cause of a trace summary error.
pub const ErrorRootCause = struct {
    /// A flag that denotes that the root cause impacts the trace client.
    client_impacting: ?bool = null,

    /// A list of services corresponding to an error. A service identifies a segment
    /// and it
    /// contains a name, account ID, type, and inferred flag.
    services: ?[]const ErrorRootCauseService = null,

    pub const json_field_names = .{
        .client_impacting = "ClientImpacting",
        .services = "Services",
    };
};
