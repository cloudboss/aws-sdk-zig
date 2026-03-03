const SsmControls = @import("ssm_controls.zig").SsmControls;

/// The controls that Config uses for executing remediations.
pub const ExecutionControls = struct {
    /// A SsmControls object.
    ssm_controls: ?SsmControls = null,

    pub const json_field_names = .{
        .ssm_controls = "SsmControls",
    };
};
