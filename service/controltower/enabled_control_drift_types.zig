const EnabledControlInheritanceDrift = @import("enabled_control_inheritance_drift.zig").EnabledControlInheritanceDrift;
const EnabledControlResourceDrift = @import("enabled_control_resource_drift.zig").EnabledControlResourceDrift;

/// Defines the various categories of drift that can occur for an enabled
/// control resource.
pub const EnabledControlDriftTypes = struct {
    /// Indicates drift related to inheritance configuration between parent and
    /// child controls.
    inheritance: ?EnabledControlInheritanceDrift = null,

    /// Indicates drift related to the underlying Amazon Web Services resources
    /// managed by the control.
    resource: ?EnabledControlResourceDrift = null,

    pub const json_field_names = .{
        .inheritance = "inheritance",
        .resource = "resource",
    };
};
