const Architecture = @import("architecture.zig").Architecture;

/// Configuration for the CPU architecture of a MicroVM.
pub const CpuConfiguration = struct {
    /// The CPU architecture.
    architecture: Architecture,

    pub const json_field_names = .{
        .architecture = "architecture",
    };
};
