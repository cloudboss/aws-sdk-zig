/// Contains information about the configuration of a model in a deployment.
pub const EdgeDeploymentModelConfig = struct {
    /// The edge packaging job associated with this deployment.
    edge_packaging_job_name: []const u8,

    /// The name the device application uses to reference this model.
    model_handle: []const u8,

    pub const json_field_names = .{
        .edge_packaging_job_name = "EdgePackagingJobName",
        .model_handle = "ModelHandle",
    };
};
