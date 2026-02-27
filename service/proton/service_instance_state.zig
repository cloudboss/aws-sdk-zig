/// The detailed data about the current state of this service instance.
pub const ServiceInstanceState = struct {
    /// The IDs for the last successful components deployed for this service
    /// instance.
    last_successful_component_deployment_ids: ?[]const []const u8,

    /// The ID for the last successful environment deployed for this service
    /// instance.
    last_successful_environment_deployment_id: ?[]const u8,

    /// The ID for the last successful service pipeline deployed for this service
    /// instance.
    last_successful_service_pipeline_deployment_id: ?[]const u8,

    /// The service spec that was used to create the service instance.
    spec: []const u8,

    /// The major version of the service template that was used to create the
    /// service
    /// pipeline.
    template_major_version: []const u8,

    /// The minor version of the service template that was used to create the
    /// service
    /// pipeline.
    template_minor_version: []const u8,

    /// The name of the service template that was used to create the service
    /// instance.
    template_name: []const u8,

    pub const json_field_names = .{
        .last_successful_component_deployment_ids = "lastSuccessfulComponentDeploymentIds",
        .last_successful_environment_deployment_id = "lastSuccessfulEnvironmentDeploymentId",
        .last_successful_service_pipeline_deployment_id = "lastSuccessfulServicePipelineDeploymentId",
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
