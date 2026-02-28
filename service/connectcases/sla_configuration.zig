const SlaStatus = @import("sla_status.zig").SlaStatus;
const FieldValueUnion = @import("field_value_union.zig").FieldValueUnion;
const SlaType = @import("sla_type.zig").SlaType;

/// Represents an SLA configuration.
pub const SlaConfiguration = struct {
    /// Time at which an SLA was completed.
    completion_time: ?i64,

    /// Unique identifier of a field.
    field_id: ?[]const u8,

    /// Name of an SLA.
    name: []const u8,

    /// Status of an SLA.
    status: SlaStatus,

    /// Represents a list of target field values for the fieldId specified in
    /// SlaConfiguration.
    target_field_values: ?[]const FieldValueUnion,

    /// Target time by which an SLA should be completed.
    target_time: i64,

    /// Type of SLA.
    @"type": SlaType,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .field_id = "fieldId",
        .name = "name",
        .status = "status",
        .target_field_values = "targetFieldValues",
        .target_time = "targetTime",
        .@"type" = "type",
    };
};
