const ChangeAction = @import("change_action.zig").ChangeAction;
const ResourceChangeDetail = @import("resource_change_detail.zig").ResourceChangeDetail;
const ModuleInfo = @import("module_info.zig").ModuleInfo;
const PolicyAction = @import("policy_action.zig").PolicyAction;
const Replacement = @import("replacement.zig").Replacement;
const ResourceDriftIgnoredAttribute = @import("resource_drift_ignored_attribute.zig").ResourceDriftIgnoredAttribute;
const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;
const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;

/// The `ResourceChange` structure describes the resource and the action that
/// CloudFormation will perform on it if you execute this change set.
pub const ResourceChange = struct {
    /// The action that CloudFormation takes on the resource, such as `Add` (adds a
    /// new
    /// resource), `Modify` (changes a resource), `Remove` (deletes a resource),
    /// `Import` (imports a resource), `Dynamic` (exact action for the resource
    /// can't be determined), or `SyncWithActual` (resource will not be changed,
    /// only
    /// CloudFormation metadata will change).
    action: ?ChangeAction,

    /// An encoded JSON string that contains the context of the resource after the
    /// change is
    /// executed.
    after_context: ?[]const u8,

    /// An encoded JSON string that contains the context of the resource before the
    /// change is
    /// executed.
    before_context: ?[]const u8,

    /// The change set ID of the nested change set.
    change_set_id: ?[]const u8,

    /// For the `Modify` action, a list of `ResourceChangeDetail` structures
    /// that describes the changes that CloudFormation will make to the resource.
    details: ?[]const ResourceChangeDetail,

    /// The resource's logical ID, which is defined in the stack's template.
    logical_resource_id: ?[]const u8,

    /// Contains information about the module from which the resource was created,
    /// if the resource
    /// was created from a module included in the stack template.
    module_info: ?ModuleInfo,

    /// The resource's physical ID (resource name). Resources that you are adding
    /// don't have
    /// physical IDs because they haven't been created.
    physical_resource_id: ?[]const u8,

    /// The action that will be taken on the physical resource when the change set
    /// is
    /// executed.
    ///
    /// * `Delete` The resource will be deleted.
    ///
    /// * `Retain` The resource will be retained.
    ///
    /// * `Snapshot` The resource will have a snapshot taken.
    ///
    /// * `ReplaceAndDelete` The resource will be replaced and then deleted.
    ///
    /// * `ReplaceAndRetain` The resource will be replaced and then retained.
    ///
    /// * `ReplaceAndSnapshot` The resource will be replaced and then have a
    ///   snapshot
    /// taken.
    policy_action: ?PolicyAction,

    /// Information about the resource's state from the previous CloudFormation
    /// deployment.
    previous_deployment_context: ?[]const u8,

    /// For the `Modify` action, indicates whether CloudFormation will replace the
    /// resource
    /// by creating a new one and deleting the old one. This value depends on the
    /// value of the
    /// `RequiresRecreation` property in the `ResourceTargetDefinition` structure.
    /// For example, if the `RequiresRecreation` field is `Always` and the
    /// `Evaluation` field is `Static`, `Replacement` is
    /// `True`. If the `RequiresRecreation` field is `Always` and the
    /// `Evaluation` field is `Dynamic`, `Replacement` is
    /// `Conditional`.
    ///
    /// If you have multiple changes with different `RequiresRecreation` values, the
    /// `Replacement` value depends on the change with the most impact. A
    /// `RequiresRecreation` value of `Always` has the most impact, followed by
    /// `Conditional`, and then `Never`.
    replacement: ?Replacement,

    /// List of resource attributes for which drift was ignored.
    resource_drift_ignored_attributes: ?[]const ResourceDriftIgnoredAttribute,

    /// The drift status of the resource. Valid values:
    ///
    /// * `IN_SYNC` – The resource matches its template definition.
    ///
    /// * `MODIFIED` – Resource properties were modified outside CloudFormation.
    ///
    /// * `DELETED` – The resource was deleted outside CloudFormation.
    ///
    /// * `NOT_CHECKED` – CloudFormation doesn’t currently return this value.
    ///
    /// * `UNKNOWN` – Drift status could not be determined.
    ///
    /// * `UNSUPPORTED` – Resource type does not support actual state comparison.
    ///
    /// Only present for drift-aware change sets.
    resource_drift_status: ?StackResourceDriftStatus,

    /// The type of CloudFormation resource, such as `AWS::S3::Bucket`.
    resource_type: ?[]const u8,

    /// For the `Modify` action, indicates which resource attribute is triggering
    /// this
    /// update, such as a change in the resource attribute's `Metadata`,
    /// `Properties`, or `Tags`.
    scope: ?[]const ResourceAttribute,
};
