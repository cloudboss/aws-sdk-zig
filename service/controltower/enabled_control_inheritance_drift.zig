const DriftStatus = @import("drift_status.zig").DriftStatus;

/// Represents drift information related to control inheritance between
/// organizational units.
pub const EnabledControlInheritanceDrift = struct {
    /// The status of inheritance drift for the enabled control, indicating whether
    /// inheritance configuration matches expectations.
    status: ?DriftStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
