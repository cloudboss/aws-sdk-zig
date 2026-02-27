const Destination = @import("destination.zig").Destination;

/// Contains information about an audit log destination configuration.
pub const AuditLogDestinationConfiguration = struct {
    /// Contains information about an audit log destination.
    destination: Destination,

    pub const json_field_names = .{
        .destination = "destination",
    };
};
