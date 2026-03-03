const StackResourceDriftInformation = @import("stack_resource_drift_information.zig").StackResourceDriftInformation;
const ModuleInfo = @import("module_info.zig").ModuleInfo;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Contains detailed information about the specified stack resource.
pub const StackResourceDetail = struct {
    /// User defined description associated with the resource.
    description: ?[]const u8 = null,

    /// Information about whether the resource's actual configuration differs, or
    /// has
    /// *drifted*, from its expected configuration, as defined in the stack template
    /// and any values specified as template parameters. For more information, see
    /// [Detect
    /// unmanaged configuration changes to stacks and resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    drift_information: ?StackResourceDriftInformation = null,

    /// Time the status was updated.
    last_updated_timestamp: i64,

    /// The logical name of the resource specified in the template.
    logical_resource_id: []const u8,

    /// The content of the `Metadata` attribute declared for the resource. For more
    /// information, see [Metadata
    /// attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-metadata.html)
    /// in the *CloudFormation User Guide*.
    metadata: ?[]const u8 = null,

    /// Contains information about the module from which the resource was created,
    /// if the resource
    /// was created from a module included in the stack template.
    module_info: ?ModuleInfo = null,

    /// The name or unique identifier that corresponds to a physical instance ID of
    /// a resource
    /// supported by CloudFormation.
    physical_resource_id: ?[]const u8 = null,

    /// Current status of the resource.
    resource_status: ResourceStatus,

    /// Success/failure message associated with the resource.
    resource_status_reason: ?[]const u8 = null,

    /// Type of resource. For more information, see [Amazon Web Services resource
    /// and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.
    resource_type: []const u8,

    /// Unique identifier of the stack.
    stack_id: ?[]const u8 = null,

    /// The name associated with the stack.
    stack_name: ?[]const u8 = null,
};
