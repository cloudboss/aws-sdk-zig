const AutoExportPolicy = @import("auto_export_policy.zig").AutoExportPolicy;
const NfsVersion = @import("nfs_version.zig").NfsVersion;

/// The configuration for a data repository association that
/// links an Amazon File Cache resource to an NFS data repository.
pub const NFSDataRepositoryConfiguration = struct {
    /// This parameter is not supported for Amazon File Cache.
    auto_export_policy: ?AutoExportPolicy = null,

    /// A list of up to 2 IP addresses of DNS servers used to resolve
    /// the NFS file system domain name. The provided IP addresses can either
    /// be the IP addresses of a DNS forwarder or resolver that the customer
    /// manages and runs inside the customer VPC, or the IP addresses of the
    /// on-premises DNS servers.
    dns_ips: ?[]const []const u8 = null,

    /// The version of the NFS (Network File System) protocol of the
    /// NFS data repository. Currently, the only supported value is
    /// `NFS3`, which indicates that the data repository must
    /// support the NFSv3 protocol.
    version: NfsVersion,

    pub const json_field_names = .{
        .auto_export_policy = "AutoExportPolicy",
        .dns_ips = "DnsIps",
        .version = "Version",
    };
};
