/// Metadata related to the configuration properties used during update of a
/// specific
/// network function in a network instance.
pub const ModifyVnfInfoMetadata = struct {
    /// The configurable properties used during update of the network function
    /// instance.
    vnf_configurable_properties: []const u8,

    /// The network function instance that was updated in the network instance.
    vnf_instance_id: []const u8,

    pub const json_field_names = .{
        .vnf_configurable_properties = "vnfConfigurableProperties",
        .vnf_instance_id = "vnfInstanceId",
    };
};
