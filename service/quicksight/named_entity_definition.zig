const NamedEntityDefinitionMetric = @import("named_entity_definition_metric.zig").NamedEntityDefinitionMetric;
const PropertyRole = @import("property_role.zig").PropertyRole;
const PropertyUsage = @import("property_usage.zig").PropertyUsage;

/// A structure that represents a named entity.
pub const NamedEntityDefinition = struct {
    /// The name of the entity.
    field_name: ?[]const u8,

    /// The definition of a metric.
    metric: ?NamedEntityDefinitionMetric,

    /// The property name to be used for the named entity.
    property_name: ?[]const u8,

    /// The property role. Valid values for this structure are `PRIMARY` and `ID`.
    property_role: ?PropertyRole,

    /// The property usage. Valid values for this structure are `INHERIT`,
    /// `DIMENSION`,
    /// and `MEASURE`.
    property_usage: ?PropertyUsage,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .metric = "Metric",
        .property_name = "PropertyName",
        .property_role = "PropertyRole",
        .property_usage = "PropertyUsage",
    };
};
