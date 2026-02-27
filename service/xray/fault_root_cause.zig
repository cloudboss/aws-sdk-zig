const FaultRootCauseService = @import("fault_root_cause_service.zig").FaultRootCauseService;

/// The root cause information for a trace summary fault.
pub const FaultRootCause = struct {
    /// A flag that denotes that the root cause impacts the trace client.
    client_impacting: ?bool,

    /// A list of corresponding services. A service identifies a segment and it
    /// contains a
    /// name, account ID, type, and inferred flag.
    services: ?[]const FaultRootCauseService,

    pub const json_field_names = .{
        .client_impacting = "ClientImpacting",
        .services = "Services",
    };
};
