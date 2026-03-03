/// Metadata related to the configuration properties used during instantiation
/// of the network instance.
pub const InstantiateMetadata = struct {
    /// The configurable properties used during instantiation.
    additional_params_for_ns: ?[]const u8 = null,

    /// The network service descriptor used for instantiating the network instance.
    nsd_info_id: []const u8,

    pub const json_field_names = .{
        .additional_params_for_ns = "additionalParamsForNs",
        .nsd_info_id = "nsdInfoId",
    };
};
