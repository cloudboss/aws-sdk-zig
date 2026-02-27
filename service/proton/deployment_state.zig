const ComponentState = @import("component_state.zig").ComponentState;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;
const ServiceInstanceState = @import("service_instance_state.zig").ServiceInstanceState;
const ServicePipelineState = @import("service_pipeline_state.zig").ServicePipelineState;

/// The detailed data about the current state of the deployment.
pub const DeploymentState = union(enum) {
    /// The state of the component associated with the deployment.
    component: ?ComponentState,
    /// The state of the environment associated with the deployment.
    environment: ?EnvironmentState,
    /// The state of the service instance associated with the deployment.
    service_instance: ?ServiceInstanceState,
    /// The state of the service pipeline associated with the deployment.
    service_pipeline: ?ServicePipelineState,

    pub const json_field_names = .{
        .component = "component",
        .environment = "environment",
        .service_instance = "serviceInstance",
        .service_pipeline = "servicePipeline",
    };
};
