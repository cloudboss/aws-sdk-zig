const aws = @import("aws");

const RegionAvailabilityStatus = @import("region_availability_status.zig").RegionAvailabilityStatus;
const SecurityControlProperty = @import("security_control_property.zig").SecurityControlProperty;
const ParameterDefinition = @import("parameter_definition.zig").ParameterDefinition;
const SeverityRating = @import("severity_rating.zig").SeverityRating;

/// Provides metadata for a security control, including its unique
/// standard-agnostic identifier, title, description,
/// severity, availability in Amazon Web Services Regions, and a link to
/// remediation steps.
pub const SecurityControlDefinition = struct {
    /// Specifies whether a security control is available in the current Amazon Web
    /// Services Region.
    current_region_availability: RegionAvailabilityStatus,

    /// Security control properties that you can customize. Currently, only
    /// parameter customization is supported for select
    /// controls. An empty array is returned for controls that don’t support custom
    /// properties.
    customizable_properties: ?[]const SecurityControlProperty = null,

    /// The description of a security control across standards. This typically
    /// summarizes how
    /// Security Hub evaluates the control and the conditions under which it
    /// produces a
    /// failed finding. This parameter doesn't reference a specific standard.
    description: []const u8,

    /// An object that provides a security control parameter name, description, and
    /// the options for customizing it. This
    /// object is excluded for a control that doesn't support custom parameters.
    parameter_definitions: ?[]const aws.map.MapEntry(ParameterDefinition) = null,

    /// A link to Security Hub documentation that explains how to remediate a failed
    /// finding for a security control.
    remediation_url: []const u8,

    /// The unique identifier of a security control across standards. Values for
    /// this field typically consist of an
    /// Amazon Web Services service name and a number (for example, APIGateway.3).
    /// This parameter differs from
    /// `SecurityControlArn`, which is a unique Amazon Resource Name (ARN) assigned
    /// to a control. The
    /// ARN references the security control ID (for example,
    /// arn:aws:securityhub:eu-central-1:123456789012:security-control/APIGateway.3).
    security_control_id: []const u8,

    /// The severity of a security control. For more information about how Security
    /// Hub determines control severity,
    /// see [Assigning severity to control
    /// findings](https://docs.aws.amazon.com/securityhub/latest/userguide/controls-findings-create-update.html#control-findings-severity) in the
    /// *Security Hub User Guide*.
    severity_rating: SeverityRating,

    /// The title of a security control.
    title: []const u8,

    pub const json_field_names = .{
        .current_region_availability = "CurrentRegionAvailability",
        .customizable_properties = "CustomizableProperties",
        .description = "Description",
        .parameter_definitions = "ParameterDefinitions",
        .remediation_url = "RemediationUrl",
        .security_control_id = "SecurityControlId",
        .severity_rating = "SeverityRating",
        .title = "Title",
    };
};
