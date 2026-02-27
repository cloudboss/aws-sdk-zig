const StackResourceDriftInformationSummary = @import("stack_resource_drift_information_summary.zig").StackResourceDriftInformationSummary;
const ModuleInfo = @import("module_info.zig").ModuleInfo;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Contains high-level information about the specified stack resource.
pub const StackResourceSummary = struct {
    /// Information about whether the resource's actual configuration differs, or
    /// has
    /// *drifted*, from its expected configuration, as defined in the stack template
    /// and any values specified as template parameters. For more information, see
    /// [Detect
    /// unmanaged configuration changes to stacks and resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    drift_information: ?StackResourceDriftInformationSummary,

    /// Time the status was updated.
    last_updated_timestamp: i64,

    /// The logical name of the resource specified in the template.
    logical_resource_id: []const u8,

    /// Contains information about the module from which the resource was created,
    /// if the resource
    /// was created from a module included in the stack template.
    module_info: ?ModuleInfo,

    /// The name or unique identifier that corresponds to a physical instance ID of
    /// the
    /// resource.
    physical_resource_id: ?[]const u8,

    /// Current status of the resource.
    resource_status: ResourceStatus,

    /// Success/failure message associated with the resource.
    resource_status_reason: ?[]const u8,

    /// Type of resource. (For more information, see [Amazon Web Services resource
    /// and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.)
    resource_type: []const u8,
};
