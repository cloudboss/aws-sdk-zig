/// The network type of a cluster. NetworkType can be one of the following:
///
/// IPV4: Cluster endpoints support IPv4 only.
///
/// DUALSTACK: Cluster endpoints support both IPv4 and IPv6.
pub const NetworkType = enum {
    ipv4,
    dualstack,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .dualstack = "DUALSTACK",
    };
};
