/// Describes the cores available to the neuron accelerator.
pub const NeuronDeviceCoreInfo = struct {
    /// The number of cores available to the neuron accelerator.
    count: ?i32 = null,

    /// The version of the neuron accelerator.
    version: ?i32 = null,
};
