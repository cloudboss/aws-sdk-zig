const ControlBehavior = @import("control_behavior.zig").ControlBehavior;
const ImplementationSummary = @import("implementation_summary.zig").ImplementationSummary;
const ParameterRequirementSummary = @import("parameter_requirement_summary.zig").ParameterRequirementSummary;
const ControlSeverity = @import("control_severity.zig").ControlSeverity;

/// Overview of information about a control.
pub const ControlSummary = struct {
    /// A list of alternative identifiers for the control. These are human-readable
    /// designators, such as `SH.S3.1`. Several aliases can refer to the same
    /// control across different Amazon Web Services services or compliance
    /// frameworks.
    aliases: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the control.
    arn: []const u8,

    /// An enumerated type, with the following possible values:
    behavior: ?ControlBehavior = null,

    /// A timestamp that notes the time when the control was released (start of its
    /// life) as a governance capability in Amazon Web Services.
    create_time: ?i64 = null,

    /// A description of the control, as it may appear in the console. Describes the
    /// functionality of the control.
    description: []const u8,

    /// A list of providers whose resources are governed by this control. For
    /// example, a value of `AWS` indicates that the control governs Amazon Web
    /// Services resources.
    governed_providers: ?[]const []const u8 = null,

    /// A list of resource types that are governed by this control. This information
    /// helps you understand which controls can govern certain types of resources,
    /// and conversely, which resources are affected when the control is
    /// implemented. For Amazon Web Services controls, the resources are represented
    /// as CloudFormation resource types. For non-Amazon Web Services controls, the
    /// resources are represented in a provider-specific format. If
    /// `GovernedResources` cannot be represented by available resource types, it’s
    /// returned as an empty list.
    governed_resources: ?[]const []const u8 = null,

    /// An object of type `ImplementationSummary` that describes how the control is
    /// implemented.
    implementation: ?ImplementationSummary = null,

    /// The display name of the control.
    name: []const u8,

    /// A summary that indicates whether the control requires parameters, accepts
    /// optional parameters, or does not support parameters. Use this field to
    /// determine whether you need to supply parameter values when you enable the
    /// control.
    parameter_requirement_summary: ?ParameterRequirementSummary = null,

    /// An enumerated type, with the following possible values:
    severity: ?ControlSeverity = null,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .arn = "Arn",
        .behavior = "Behavior",
        .create_time = "CreateTime",
        .description = "Description",
        .governed_providers = "GovernedProviders",
        .governed_resources = "GovernedResources",
        .implementation = "Implementation",
        .name = "Name",
        .parameter_requirement_summary = "ParameterRequirementSummary",
        .severity = "Severity",
    };
};
