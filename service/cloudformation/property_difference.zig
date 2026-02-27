const DifferenceType = @import("difference_type.zig").DifferenceType;

/// Information about a resource property whose actual value differs from its
/// expected value, as
/// defined in the stack template and any values specified as template
/// parameters. These will be
/// present only for resources whose `StackResourceDriftStatus` is `MODIFIED`.
/// For more information, see [Detect unmanaged
/// configuration changes to stacks and resources with drift
/// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
pub const PropertyDifference = struct {
    /// The actual property value of the resource property.
    actual_value: []const u8,

    /// The type of property difference.
    ///
    /// * `ADD`: A value has been added to a resource property that's an array or
    ///   list
    /// data type.
    ///
    /// * `REMOVE`: The property has been removed from the current resource
    /// configuration.
    ///
    /// * `NOT_EQUAL`: The current property value differs from its expected value
    ///   (as
    /// defined in the stack template and any values specified as template
    /// parameters).
    difference_type: DifferenceType,

    /// The expected property value of the resource property, as defined in the
    /// stack template and
    /// any values specified as template parameters.
    expected_value: []const u8,

    /// The fully-qualified path to the resource property.
    property_path: []const u8,
};
