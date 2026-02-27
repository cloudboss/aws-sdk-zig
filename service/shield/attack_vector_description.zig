/// Describes the attack.
pub const AttackVectorDescription = struct {
    /// The attack type. Valid values:
    ///
    /// * UDP_TRAFFIC
    ///
    /// * UDP_FRAGMENT
    ///
    /// * GENERIC_UDP_REFLECTION
    ///
    /// * DNS_REFLECTION
    ///
    /// * NTP_REFLECTION
    ///
    /// * CHARGEN_REFLECTION
    ///
    /// * SSDP_REFLECTION
    ///
    /// * PORT_MAPPER
    ///
    /// * RIP_REFLECTION
    ///
    /// * SNMP_REFLECTION
    ///
    /// * MSSQL_REFLECTION
    ///
    /// * NET_BIOS_REFLECTION
    ///
    /// * SYN_FLOOD
    ///
    /// * ACK_FLOOD
    ///
    /// * REQUEST_FLOOD
    ///
    /// * HTTP_REFLECTION
    ///
    /// * UDS_REFLECTION
    ///
    /// * MEMCACHED_REFLECTION
    vector_type: []const u8,

    pub const json_field_names = .{
        .vector_type = "VectorType",
    };
};
