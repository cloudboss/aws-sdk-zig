pub const ThirdPartyFirewall = enum {
    palo_alto_networks_cloud_ngfw,
    fortigate_cloud_native_firewall,

    pub const json_field_names = .{
        .palo_alto_networks_cloud_ngfw = "PALO_ALTO_NETWORKS_CLOUD_NGFW",
        .fortigate_cloud_native_firewall = "FORTIGATE_CLOUD_NATIVE_FIREWALL",
    };
};
