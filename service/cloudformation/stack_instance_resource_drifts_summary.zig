const PhysicalResourceIdContextKeyValuePair = @import("physical_resource_id_context_key_value_pair.zig").PhysicalResourceIdContextKeyValuePair;
const PropertyDifference = @import("property_difference.zig").PropertyDifference;
const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;

/// The structure containing summary information about resource drifts for a
/// stack
/// instance.
pub const StackInstanceResourceDriftsSummary = struct {
    /// The logical name of the resource specified in the template.
    logical_resource_id: []const u8,

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

    /// Status of the actual configuration of the resource compared to its expected
    /// configuration.
    /// These will be present only for resources whose
    /// `StackInstanceResourceDriftStatus` is
    /// `MODIFIED`.
    property_differences: ?[]const PropertyDifference = null,

    /// Type of resource. For more information, see [Amazon Web Services resource
    /// and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.
    resource_type: []const u8,

    /// The ID of the stack instance.
    stack_id: []const u8,

    /// The drift status of the resource in a stack instance.
    ///
    /// * `DELETED`: The resource differs from its expected template configuration
    ///   in
    /// that the resource has been deleted.
    ///
    /// * `MODIFIED`: One or more resource properties differ from their expected
    ///   template
    /// values.
    ///
    /// * `IN_SYNC`: The resource's actual configuration matches its expected
    ///   template
    /// configuration.
    ///
    /// * `NOT_CHECKED`: CloudFormation doesn't currently return this value.
    stack_resource_drift_status: StackResourceDriftStatus,

    /// Time at which the stack instance drift detection operation was initiated.
    timestamp: i64,
};
