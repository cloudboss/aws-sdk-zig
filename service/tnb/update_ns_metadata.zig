/// Metadata related to the configuration properties used during update of a
/// network instance.
pub const UpdateNsMetadata = struct {
    /// The configurable properties used during update.
    additional_params_for_ns: ?[]const u8 = null,

    /// The network service descriptor used for updating the network instance.
    nsd_info_id: []const u8,

    pub const json_field_names = .{
        .additional_params_for_ns = "additionalParamsForNs",
        .nsd_info_id = "nsdInfoId",
    };
};
