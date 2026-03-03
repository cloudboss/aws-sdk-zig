/// Information parameters and/or the configurable properties for a network
/// descriptor used for update.
pub const UpdateSolNetworkServiceData = struct {
    /// Values for the configurable properties declared in the network service
    /// descriptor.
    additional_params_for_ns: ?[]const u8 = null,

    /// ID of the network service descriptor.
    nsd_info_id: []const u8,

    pub const json_field_names = .{
        .additional_params_for_ns = "additionalParamsForNs",
        .nsd_info_id = "nsdInfoId",
    };
};
