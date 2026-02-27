const FieldValueUnion = @import("field_value_union.zig").FieldValueUnion;
const SlaType = @import("sla_type.zig").SlaType;

/// Represents the input configuration of an SLA being created.
pub const SlaInputConfiguration = struct {
    /// Unique identifier of a field.
    field_id: ?[]const u8,

    /// Name of an SLA.
    name: []const u8,

    /// Represents a list of target field values for the fieldId specified in
    /// SlaInputConfiguration. The SLA is considered met if any one of these target
    /// field values matches the actual field value.
    target_field_values: ?[]const FieldValueUnion,

    /// Target duration in minutes within which an SLA should be completed.
    target_sla_minutes: i64,

    /// Type of SLA.
    type: SlaType,

    pub const json_field_names = .{
        .field_id = "fieldId",
        .name = "name",
        .target_field_values = "targetFieldValues",
        .target_sla_minutes = "targetSlaMinutes",
        .type = "type",
    };
};
