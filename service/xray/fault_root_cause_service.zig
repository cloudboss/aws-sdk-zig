const FaultRootCauseEntity = @import("fault_root_cause_entity.zig").FaultRootCauseEntity;

/// A collection of fields identifying the services in a trace summary fault.
pub const FaultRootCauseService = struct {
    /// The account ID associated to the service.
    account_id: ?[]const u8 = null,

    /// The path of root cause entities found on the service.
    entity_path: ?[]const FaultRootCauseEntity = null,

    /// A Boolean value indicating if the service is inferred from the trace.
    inferred: ?bool = null,

    /// The service name.
    name: ?[]const u8 = null,

    /// A collection of associated service names.
    names: ?[]const []const u8 = null,

    /// The type associated to the service.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .entity_path = "EntityPath",
        .inferred = "Inferred",
        .name = "Name",
        .names = "Names",
        .@"type" = "Type",
    };
};
