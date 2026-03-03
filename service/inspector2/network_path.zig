const Step = @import("step.zig").Step;

/// Information on the network path associated with a finding.
pub const NetworkPath = struct {
    /// The details on the steps in the network path.
    steps: ?[]const Step = null,

    pub const json_field_names = .{
        .steps = "steps",
    };
};
