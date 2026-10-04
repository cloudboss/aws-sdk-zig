const aws = @import("aws");

const Mount = @import("mount.zig").Mount;

/// Runtime mount overrides applied to a single pipeline execution. Overrides
/// are transient — they do not modify the stored task configuration.
pub const MountOverrides = struct {
    /// The mount overrides for each compute node, keyed by compute node name.
    compute_nodes: []const aws.map.MapEntry([]const Mount),

    pub const json_field_names = .{
        .compute_nodes = "computeNodes",
    };
};
