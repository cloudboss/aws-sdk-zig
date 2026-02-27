const ResponseTimeRootCauseEntity = @import("response_time_root_cause_entity.zig").ResponseTimeRootCauseEntity;

/// A collection of fields identifying the service in a response time warning.
pub const ResponseTimeRootCauseService = struct {
    /// The account ID associated to the service.
    account_id: ?[]const u8,

    /// The path of root cause entities found on the service.
    entity_path: ?[]const ResponseTimeRootCauseEntity,

    /// A Boolean value indicating if the service is inferred from the trace.
    inferred: ?bool,

    /// The service name.
    name: ?[]const u8,

    /// A collection of associated service names.
    names: ?[]const []const u8,

    /// The type associated to the service.
    type: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .entity_path = "EntityPath",
        .inferred = "Inferred",
        .name = "Name",
        .names = "Names",
        .type = "Type",
    };
};
