/// The configuration to use to enable the different types of interactive use
/// cases in an application.
pub const InteractiveConfiguration = struct {
    /// Enables an Apache Livy endpoint that you can connect to and run interactive
    /// jobs.
    livy_endpoint_enabled: ?bool = null,

    /// Enables you to connect an application to Amazon EMR Studio to run
    /// interactive workloads in a notebook.
    studio_enabled: ?bool = null,

    pub const json_field_names = .{
        .livy_endpoint_enabled = "livyEndpointEnabled",
        .studio_enabled = "studioEnabled",
    };
};
