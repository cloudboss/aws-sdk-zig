/// The detailed data about the current state of the component.
pub const ComponentState = struct {
    /// The name of the service instance that this component is attached to.
    /// Provided when a component is attached to a service instance.
    service_instance_name: ?[]const u8,

    /// The name of the service that `serviceInstanceName` is associated with.
    /// Provided when a component is attached to a service instance.
    service_name: ?[]const u8,

    /// The service spec that the component uses to access service inputs. Provided
    /// when a component is attached to a service instance.
    service_spec: ?[]const u8,

    /// The template file used.
    template_file: ?[]const u8,

    pub const json_field_names = .{
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .service_spec = "serviceSpec",
        .template_file = "templateFile",
    };
};
