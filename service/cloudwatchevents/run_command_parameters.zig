const RunCommandTarget = @import("run_command_target.zig").RunCommandTarget;

/// This parameter contains the criteria (either InstanceIds or a tag) used to
/// specify which
/// EC2 instances are to be sent the command.
pub const RunCommandParameters = struct {
    /// Currently, we support including only one RunCommandTarget block, which
    /// specifies either an
    /// array of InstanceIds or a tag.
    run_command_targets: []const RunCommandTarget,

    pub const json_field_names = .{
        .run_command_targets = "RunCommandTargets",
    };
};
