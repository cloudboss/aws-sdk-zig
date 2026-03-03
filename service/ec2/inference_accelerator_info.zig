const InferenceDeviceInfo = @import("inference_device_info.zig").InferenceDeviceInfo;

/// Amazon Elastic Inference is no longer available.
///
/// Describes the Inference accelerators for the instance type.
pub const InferenceAcceleratorInfo = struct {
    /// Describes the Inference accelerators for the instance type.
    accelerators: ?[]const InferenceDeviceInfo = null,

    /// The total size of the memory for the inference accelerators for the instance
    /// type, in
    /// MiB.
    total_inference_memory_in_mi_b: ?i32 = null,
};
