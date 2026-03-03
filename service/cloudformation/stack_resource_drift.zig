const ModuleInfo = @import("module_info.zig").ModuleInfo;
const PhysicalResourceIdContextKeyValuePair = @import("physical_resource_id_context_key_value_pair.zig").PhysicalResourceIdContextKeyValuePair;
const PropertyDifference = @import("property_difference.zig").PropertyDifference;
const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;

/// Contains the drift information for a resource that has been checked for
/// drift. This includes
/// actual and expected property values for resources in which CloudFormation
/// has detected drift. Only
/// resource properties explicitly defined in the stack template are checked for
/// drift. For more
/// information, see [Detect unmanaged
/// configuration changes to stacks and resources with drift
/// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
///
/// Resources that don't currently support drift detection can't be checked. For
/// a list of
/// resources that support drift detection, see [Resource type
/// support for imports and drift
/// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html).
///
/// Use DetectStackResourceDrift to detect drift on individual resources, or
/// DetectStackDrift to detect drift on all resources in a given stack that
/// support drift detection.
pub const StackResourceDrift = struct {
    /// A JSON structure that contains the actual property values of the stack
    /// resource.
    ///
    /// For resources whose `StackResourceDriftStatus` is `DELETED`, this
    /// structure will not be present.
    actual_properties: ?[]const u8 = null,

    /// The reason for the drift status.
    drift_status_reason: ?[]const u8 = null,

    /// A JSON structure that contains the expected property values of the stack
    /// resource, as
    /// defined in the stack template and any values specified as template
    /// parameters.
    ///
    /// For resources whose `StackResourceDriftStatus` is `DELETED`, this
    /// structure will not be present.
    expected_properties: ?[]const u8 = null,

    /// The logical name of the resource specified in the template.
    logical_resource_id: []const u8,

    /// Contains information about the module from which the resource was created,
    /// if the resource
    /// was created from a module included in the stack template.
    module_info: ?ModuleInfo = null,

    /// The name or unique identifier that corresponds to a physical instance ID of
    /// a resource
    /// supported by CloudFormation.
    physical_resource_id: ?[]const u8 = null,

    /// Context information that enables CloudFormation to uniquely identify a
    /// resource. CloudFormation uses
    /// context key-value pairs in cases where a resource's logical and physical IDs
    /// aren't enough to
    /// uniquely identify that resource. Each context key-value pair specifies a
    /// unique resource that
    /// contains the targeted resource.
    physical_resource_id_context: ?[]const PhysicalResourceIdContextKeyValuePair = null,

    /// A collection of the resource properties whose actual values differ from
    /// their expected
    /// values. These will be present only for resources whose
    /// `StackResourceDriftStatus` is
    /// `MODIFIED`.
    property_differences: ?[]const PropertyDifference = null,

    /// The type of the resource.
    resource_type: []const u8,

    /// The ID of the stack.
    stack_id: []const u8,

    /// Status of the resource's actual configuration compared to its expected
    /// configuration.
    ///
    /// * `DELETED`: The resource differs from its expected template configuration
    /// because the resource has been deleted.
    ///
    /// * `MODIFIED`: One or more resource properties differ from their expected
    ///   values
    /// (as defined in the stack template and any values specified as template
    /// parameters).
    ///
    /// * `IN_SYNC`: The resource's actual configuration matches its expected
    ///   template
    /// configuration.
    ///
    /// * `NOT_CHECKED`: CloudFormation does not currently return this value.
    ///
    /// * `UNKNOWN`: CloudFormation could not run drift detection for the resource.
    ///   See the
    /// `DriftStatusReason` for details.
    stack_resource_drift_status: StackResourceDriftStatus,

    /// Time at which CloudFormation performed drift detection on the stack
    /// resource.
    timestamp: i64,
};
