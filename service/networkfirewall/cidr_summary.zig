const aws = @import("aws");

const IPSetMetadata = @import("ip_set_metadata.zig").IPSetMetadata;

/// Summarizes the CIDR blocks used by the IP set references in a firewall.
/// Network Firewall calculates the number of CIDRs by taking an aggregated
/// count of all CIDRs used by the IP sets you are referencing.
pub const CIDRSummary = struct {
    /// The number of CIDR blocks available for use by the IP set references in a
    /// firewall.
    available_cidr_count: ?i32,

    /// The list of the IP set references used by a firewall.
    ip_set_references: ?[]const aws.map.MapEntry(IPSetMetadata),

    /// The number of CIDR blocks used by the IP set references in a firewall.
    utilized_cidr_count: ?i32,

    pub const json_field_names = .{
        .available_cidr_count = "AvailableCIDRCount",
        .ip_set_references = "IPSetReferences",
        .utilized_cidr_count = "UtilizedCIDRCount",
    };
};
