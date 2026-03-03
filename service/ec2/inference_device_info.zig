const InferenceDeviceMemoryInfo = @import("inference_device_memory_info.zig").InferenceDeviceMemoryInfo;

/// Amazon Elastic Inference is no longer available.
///
/// Describes the Inference accelerators for the instance type.
pub const InferenceDeviceInfo = struct {
    /// The number of Inference accelerators for the instance type.
    count: ?i32 = null,

    /// The manufacturer of the Inference accelerator.
    manufacturer: ?[]const u8 = null,

    /// Describes the memory available to the inference accelerator.
    memory_info: ?InferenceDeviceMemoryInfo = null,

    /// The name of the Inference accelerator.
    name: ?[]const u8 = null,
};
