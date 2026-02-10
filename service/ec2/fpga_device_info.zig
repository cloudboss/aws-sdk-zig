const FpgaDeviceMemoryInfo = @import("fpga_device_memory_info.zig").FpgaDeviceMemoryInfo;

/// Describes the FPGA accelerator for the instance type.
pub const FpgaDeviceInfo = struct {
    /// The count of FPGA accelerators for the instance type.
    count: ?i32,

    /// The manufacturer of the FPGA accelerator.
    manufacturer: ?[]const u8,

    /// Describes the memory for the FPGA accelerator for the instance type.
    memory_info: ?FpgaDeviceMemoryInfo,

    /// The name of the FPGA accelerator.
    name: ?[]const u8,
};
