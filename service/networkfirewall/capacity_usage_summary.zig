const CIDRSummary = @import("cidr_summary.zig").CIDRSummary;

/// The capacity usage summary of the resources used by the ReferenceSets in a
/// firewall.
pub const CapacityUsageSummary = struct {
    /// Describes the capacity usage of the CIDR blocks used by the IP set
    /// references in a firewall.
    cid_rs: ?CIDRSummary,

    pub const json_field_names = .{
        .cid_rs = "CIDRs",
    };
};
