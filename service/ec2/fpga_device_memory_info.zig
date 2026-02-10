/// Describes the memory for the FPGA accelerator for the instance type.
pub const FpgaDeviceMemoryInfo = struct {
    /// The size of the memory available to the FPGA accelerator, in MiB.
    size_in_mi_b: ?i32,
};
