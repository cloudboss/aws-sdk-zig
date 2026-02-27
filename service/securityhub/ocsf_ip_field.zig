pub const OcsfIpField = enum {
    evidences_dst_endpoint_ip,
    evidences_src_endpoint_ip,

    pub const json_field_names = .{
        .evidences_dst_endpoint_ip = "EVIDENCES_DST_ENDPOINT_IP",
        .evidences_src_endpoint_ip = "EVIDENCES_SRC_ENDPOINT_IP",
    };
};
