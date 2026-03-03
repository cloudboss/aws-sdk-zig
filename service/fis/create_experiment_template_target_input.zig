const aws = @import("aws");

const ExperimentTemplateTargetInputFilter = @import("experiment_template_target_input_filter.zig").ExperimentTemplateTargetInputFilter;

/// Specifies a target for an experiment. You must specify at least one Amazon
/// Resource Name (ARN) or
/// at least one resource tag. You cannot specify both ARNs and tags.
///
/// For more information, see
/// [Targets](https://docs.aws.amazon.com/fis/latest/userguide/targets.html)
/// in the *Fault Injection Service User Guide*.
pub const CreateExperimentTemplateTargetInput = struct {
    /// The filters to apply to identify target resources using specific attributes.
    filters: ?[]const ExperimentTemplateTargetInputFilter = null,

    /// The resource type parameters.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Names (ARNs) of the resources.
    resource_arns: ?[]const []const u8 = null,

    /// The tags for the target resources.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The resource type. The resource type must be supported for the specified
    /// action.
    resource_type: []const u8,

    /// Scopes the identified resources to a specific count of the resources at
    /// random, or a percentage of the resources. All identified resources are
    /// included in the target.
    ///
    /// * ALL - Run the action on all identified targets. This is the default.
    ///
    /// * COUNT(n) - Run the action on the specified number of targets, chosen from
    ///   the identified targets at random.
    /// For example, COUNT(1) selects one of the targets.
    ///
    /// * PERCENT(n) - Run the action on the specified percentage of targets, chosen
    ///   from the identified targets
    /// at random. For example, PERCENT(25) selects 25% of the targets.
    selection_mode: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .parameters = "parameters",
        .resource_arns = "resourceArns",
        .resource_tags = "resourceTags",
        .resource_type = "resourceType",
        .selection_mode = "selectionMode",
    };
};
