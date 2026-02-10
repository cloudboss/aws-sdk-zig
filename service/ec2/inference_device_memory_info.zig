/// **Note:**
///
/// Amazon Elastic Inference is no longer available.
///
/// Describes the memory available to the inference accelerator.
pub const InferenceDeviceMemoryInfo = struct {
    /// The size of the memory available to the inference accelerator, in MiB.
    size_in_mi_b: ?i32,
};
