const FpgaDeviceInfo = @import("fpga_device_info.zig").FpgaDeviceInfo;

/// Describes the FPGAs for the instance type.
pub const FpgaInfo = struct {
    /// Describes the FPGAs for the instance type.
    fpgas: ?[]const FpgaDeviceInfo = null,

    /// The total memory of all FPGA accelerators for the instance type.
    total_fpga_memory_in_mi_b: ?i32 = null,
};
