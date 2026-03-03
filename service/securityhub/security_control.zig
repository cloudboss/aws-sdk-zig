const aws = @import("aws");

const ParameterConfiguration = @import("parameter_configuration.zig").ParameterConfiguration;
const ControlStatus = @import("control_status.zig").ControlStatus;
const SeverityRating = @import("severity_rating.zig").SeverityRating;
const UpdateStatus = @import("update_status.zig").UpdateStatus;

/// A security control in Security Hub describes a security best practice
/// related to a specific resource.
pub const SecurityControl = struct {
    /// The description of a security control across standards. This typically
    /// summarizes how
    /// Security Hub evaluates the control and the conditions under which it
    /// produces a
    /// failed finding. This parameter doesn't reference a specific standard.
    description: []const u8,

    /// The most recent reason for updating the customizable properties of a
    /// security control. This differs from the
    /// `UpdateReason` field of the [
    /// `BatchUpdateStandardsControlAssociations`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateStandardsControlAssociations.html) API, which tracks the
    /// reason for updating the enablement status of a control. This field accepts
    /// alphanumeric
    /// characters in addition to white spaces, dashes, and underscores.
    last_update_reason: ?[]const u8 = null,

    /// An object that identifies the name of a control parameter, its current
    /// value, and whether it has been customized.
    parameters: ?[]const aws.map.MapEntry(ParameterConfiguration) = null,

    /// A link to Security Hub documentation that explains how to remediate a failed
    /// finding for a security control.
    remediation_url: []const u8,

    /// The Amazon Resource Name (ARN) for a security control across standards, such
    /// as
    /// `arn:aws:securityhub:eu-central-1:123456789012:security-control/S3.1`. This
    /// parameter doesn't mention a specific standard.
    security_control_arn: []const u8,

    /// The unique identifier of a security control across standards. Values for
    /// this field typically consist of an Amazon Web Services service name and a
    /// number, such as APIGateway.3.
    security_control_id: []const u8,

    /// The enablement status of a security control in a specific standard.
    security_control_status: ControlStatus,

    /// The severity of a security control. For more information about how Security
    /// Hub determines control severity, see
    /// [Assigning severity to control
    /// findings](https://docs.aws.amazon.com/securityhub/latest/userguide/controls-findings-create-update.html#control-findings-severity) in the
    /// *Security Hub User Guide*.
    severity_rating: SeverityRating,

    /// The title of a security control.
    title: []const u8,

    /// Identifies whether customizable properties of a security control are
    /// reflected in Security Hub findings. A status of
    /// `READY` indicates that Security Hub uses the current control parameter
    /// values when running security checks of the control.
    /// A status of `UPDATING` indicates that all security checks might not use the
    /// current parameter values.
    update_status: ?UpdateStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .last_update_reason = "LastUpdateReason",
        .parameters = "Parameters",
        .remediation_url = "RemediationUrl",
        .security_control_arn = "SecurityControlArn",
        .security_control_id = "SecurityControlId",
        .security_control_status = "SecurityControlStatus",
        .severity_rating = "SeverityRating",
        .title = "Title",
        .update_status = "UpdateStatus",
    };
};
