/// Provides information about the endpoint of the model deployment.
pub const ModelDeployResult = struct {
    /// The name of the endpoint to which the model has been deployed.
    ///
    /// If model deployment fails, this field is omitted from the response.
    endpoint_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
    };
};
