const InferenceDeviceMemoryInfo = @import("inference_device_memory_info.zig").InferenceDeviceMemoryInfo;

/// **Note:**
///
/// Amazon Elastic Inference is no longer available.
///
/// Describes the Inference accelerators for the instance type.
pub const InferenceDeviceInfo = struct {
    /// The number of Inference accelerators for the instance type.
    count: ?i32,

    /// The manufacturer of the Inference accelerator.
    manufacturer: ?[]const u8,

    /// Describes the memory available to the inference accelerator.
    memory_info: ?InferenceDeviceMemoryInfo,

    /// The name of the Inference accelerator.
    name: ?[]const u8,
};
