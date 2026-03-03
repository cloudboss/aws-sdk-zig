const Gpu = @import("gpu.zig").Gpu;

/// Describes the GPU accelerator settings for the instance type.
pub const GpuInfo = struct {
    /// Describes the GPU accelerators for the instance type.
    gpus: ?[]const Gpu = null,

    pub const json_field_names = .{
        .gpus = "gpus",
    };
};
