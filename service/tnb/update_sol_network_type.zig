pub const UpdateSolNetworkType = enum {
    modify_vnf_information,
    update_ns,

    pub const json_field_names = .{
        .modify_vnf_information = "MODIFY_VNF_INFORMATION",
        .update_ns = "UPDATE_NS",
    };
};
