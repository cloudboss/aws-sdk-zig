const aws = @import("aws");

const StandardsControlsUpdatable = @import("standards_controls_updatable.zig").StandardsControlsUpdatable;
const StandardsStatus = @import("standards_status.zig").StandardsStatus;
const StandardsStatusReason = @import("standards_status_reason.zig").StandardsStatusReason;

/// A resource that represents your subscription to a supported standard.
pub const StandardsSubscription = struct {
    /// The ARN of the standard.
    standards_arn: []const u8,

    /// Specifies whether you can retrieve information about and configure
    /// individual controls that apply to the standard. Possible values are:
    ///
    /// * `READY_FOR_UPDATES` - Controls in the standard can be retrieved and
    ///   configured.
    ///
    /// * `NOT_READY_FOR_UPDATES` - Controls in the standard cannot be retrieved or
    ///   configured.
    standards_controls_updatable: ?StandardsControlsUpdatable = null,

    /// A key-value pair of input for the standard.
    standards_input: []const aws.map.StringMapEntry,

    /// The status of your subscription to the standard. Possible values are:
    ///
    /// * `PENDING` - The standard is in the process of being enabled. Or the
    ///   standard is already
    /// enabled and Security Hub CSPM is adding new controls to the standard.
    ///
    /// * `READY` - The standard is enabled.
    ///
    /// * `INCOMPLETE` - The standard could not be enabled completely. One or more
    ///   errors (`StandardsStatusReason`)
    /// occurred when Security Hub CSPM attempted to enable the standard.
    ///
    /// * `DELETING` - The standard is in the process of being disabled.
    ///
    /// * `FAILED` - The standard could not be disabled. One or more errors
    ///   (`StandardsStatusReason`)
    /// occurred when Security Hub CSPM attempted to disable the standard.
    standards_status: StandardsStatus,

    /// The reason for the current status.
    standards_status_reason: ?StandardsStatusReason = null,

    /// The ARN of the resource that represents your subscription to the standard.
    standards_subscription_arn: []const u8,

    pub const json_field_names = .{
        .standards_arn = "StandardsArn",
        .standards_controls_updatable = "StandardsControlsUpdatable",
        .standards_input = "StandardsInput",
        .standards_status = "StandardsStatus",
        .standards_status_reason = "StandardsStatusReason",
        .standards_subscription_arn = "StandardsSubscriptionArn",
    };
};
