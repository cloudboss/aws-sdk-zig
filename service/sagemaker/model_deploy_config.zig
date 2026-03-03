/// Specifies how to generate the endpoint name for an automatic one-click
/// Autopilot model deployment.
pub const ModelDeployConfig = struct {
    /// Set to `True` to automatically generate an endpoint name for a one-click
    /// Autopilot model deployment; set to `False` otherwise. The default value is
    /// `False`.
    ///
    /// If you set `AutoGenerateEndpointName` to `True`, do not specify the
    /// `EndpointName`; otherwise a 400 error is thrown.
    auto_generate_endpoint_name: ?bool = null,

    /// Specifies the endpoint name to use for a one-click Autopilot model
    /// deployment if the endpoint name is not generated automatically.
    ///
    /// Specify the `EndpointName` if and only if you set `AutoGenerateEndpointName`
    /// to `False`; otherwise a 400 error is thrown.
    endpoint_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_generate_endpoint_name = "AutoGenerateEndpointName",
        .endpoint_name = "EndpointName",
    };
};
