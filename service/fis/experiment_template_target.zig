const aws = @import("aws");

const ExperimentTemplateTargetFilter = @import("experiment_template_target_filter.zig").ExperimentTemplateTargetFilter;

/// Describes a target for an experiment template.
pub const ExperimentTemplateTarget = struct {
    /// The filters to apply to identify target resources using specific attributes.
    filters: ?[]const ExperimentTemplateTargetFilter = null,

    /// The resource type parameters.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Names (ARNs) of the targets.
    resource_arns: ?[]const []const u8 = null,

    /// The tags for the target resources.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    /// Scopes the identified resources to a specific count or percentage.
    selection_mode: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .parameters = "parameters",
        .resource_arns = "resourceArns",
        .resource_tags = "resourceTags",
        .resource_type = "resourceType",
        .selection_mode = "selectionMode",
    };
};
