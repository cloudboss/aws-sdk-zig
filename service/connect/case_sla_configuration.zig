const FieldValueUnion = @import("field_value_union.zig").FieldValueUnion;
const SlaType = @import("sla_type.zig").SlaType;

/// The SLA configuration for Case SlaAssignmentType.
pub const CaseSlaConfiguration = struct {
    /// Unique identifier of a Case field.
    field_id: ?[]const u8 = null,

    /// Name of an SLA.
    name: []const u8,

    /// Represents a list of target field values for the fieldId specified in
    /// CaseSlaConfiguration. The SLA is
    /// considered met if any one of these target field values matches the actual
    /// field value.
    target_field_values: ?[]const FieldValueUnion = null,

    /// Target duration in minutes within which an SLA should be completed.
    target_sla_minutes: i64,

    /// Type of SLA for Case SlaAssignmentType.
    @"type": SlaType,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .name = "Name",
        .target_field_values = "TargetFieldValues",
        .target_sla_minutes = "TargetSlaMinutes",
        .@"type" = "Type",
    };
};
