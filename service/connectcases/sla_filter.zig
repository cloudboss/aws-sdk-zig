const SlaStatus = @import("sla_status.zig").SlaStatus;

/// A filter for related items of type `SLA`.
pub const SlaFilter = struct {
    /// Name of an SLA.
    name: ?[]const u8 = null,

    /// Status of an SLA.
    status: ?SlaStatus = null,

    pub const json_field_names = .{
        .name = "name",
        .status = "status",
    };
};
