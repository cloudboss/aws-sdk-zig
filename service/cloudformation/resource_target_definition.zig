const AfterValueFrom = @import("after_value_from.zig").AfterValueFrom;
const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;
const AttributeChangeType = @import("attribute_change_type.zig").AttributeChangeType;
const BeforeValueFrom = @import("before_value_from.zig").BeforeValueFrom;
const LiveResourceDrift = @import("live_resource_drift.zig").LiveResourceDrift;
const RequiresRecreation = @import("requires_recreation.zig").RequiresRecreation;

/// The field that CloudFormation will change, such as the name of a resource's
/// property, and
/// whether the resource will be recreated.
pub const ResourceTargetDefinition = struct {
    /// The value of the property after the change is executed. Large values can be
    /// truncated.
    after_value: ?[]const u8,

    /// Indicates the source of the after value. Valid value:
    ///
    /// * `TEMPLATE` – The after value comes from the new template.
    ///
    /// Only present for drift-aware change sets.
    after_value_from: ?AfterValueFrom,

    /// Indicates which resource attribute is triggering this update, such as a
    /// change in the
    /// resource attribute's `Metadata`, `Properties`, or `Tags`.
    attribute: ?ResourceAttribute,

    /// The type of change to be made to the property if the change is executed.
    ///
    /// * `Add` The item will be added.
    ///
    /// * `Remove` The item will be removed.
    ///
    /// * `Modify` The item will be modified.
    ///
    /// * `SyncWithActual` The drift status of this item will be reset but the item
    ///   will
    /// not be modified.
    attribute_change_type: ?AttributeChangeType,

    /// The value of the property before the change is executed. Large values can be
    /// truncated.
    before_value: ?[]const u8,

    /// Indicates the source of the before value. Valid values:
    ///
    /// * `ACTUAL_STATE` – The before value represents current actual state.
    ///
    /// * `PREVIOUS_DEPLOYMENT_STATE` – The before value represents the previous
    /// CloudFormation deployment state.
    ///
    /// Only present for drift-aware change sets.
    before_value_from: ?BeforeValueFrom,

    /// Detailed drift information for the resource property, including actual
    /// values, previous
    /// deployment values, and drift detection timestamps.
    drift: ?LiveResourceDrift,

    /// If the `Attribute` value is `Properties`, the name of the property.
    /// For all other attributes, the value is null.
    name: ?[]const u8,

    /// The property path of the property.
    path: ?[]const u8,

    /// If the `Attribute` value is `Properties`, indicates whether a change
    /// to this property causes the resource to be recreated. The value can be
    /// `Never`,
    /// `Always`, or `Conditionally`. To determine the conditions for a
    /// `Conditionally` recreation, see the update behavior for that property in the
    /// [Amazon Web Services resource and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.
    requires_recreation: ?RequiresRecreation,
};
