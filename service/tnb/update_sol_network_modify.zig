/// Information parameters and/or the configurable properties for a network
/// function.
///
/// A network function instance is a function in a function package .
pub const UpdateSolNetworkModify = struct {
    /// Provides values for the configurable properties declared in the function
    /// package
    /// descriptor.
    vnf_configurable_properties: []const u8,

    /// ID of the network function instance.
    ///
    /// A network function instance is a function in a function package .
    vnf_instance_id: []const u8,

    pub const json_field_names = .{
        .vnf_configurable_properties = "vnfConfigurableProperties",
        .vnf_instance_id = "vnfInstanceId",
    };
};
