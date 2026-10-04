const RemediationStringField = @import("remediation_string_field.zig").RemediationStringField;
const RemediationStringFilterCondition = @import("remediation_string_filter_condition.zig").RemediationStringFilterCondition;

/// A string filter for filtering remediation targets.
pub const RemediationStringFilter = struct {
    /// The name of the filter field. Valid values are `Resource.Type`, `Priority`,
    /// `Status`, `Resource.Id`, `Resource.ResourceOwnerAccountId`, and
    /// `Resource.CloudProvider`.
    field_name: RemediationStringField,

    /// The string filter definition.
    filter: RemediationStringFilterCondition,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
