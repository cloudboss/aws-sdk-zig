/// Name/Value pair of a parameter to start execution of a SageMaker Model
/// Building
/// Pipeline.
pub const SageMakerPipelineParameter = struct {
    /// Name of parameter to start execution of a SageMaker Model Building
    /// Pipeline.
    name: []const u8,

    /// Value of parameter to start execution of a SageMaker Model Building
    /// Pipeline.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
