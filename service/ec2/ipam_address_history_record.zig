const IpamComplianceStatus = @import("ipam_compliance_status.zig").IpamComplianceStatus;
const IpamOverlapStatus = @import("ipam_overlap_status.zig").IpamOverlapStatus;
const IpamAddressHistoryResourceType = @import("ipam_address_history_resource_type.zig").IpamAddressHistoryResourceType;

/// The historical record of a CIDR within an IPAM scope. For more information,
/// see [View the history of IP
/// addresses](https://docs.aws.amazon.com/vpc/latest/ipam/view-history-cidr-ipam.html) in the *Amazon VPC IPAM User Guide*.
pub const IpamAddressHistoryRecord = struct {
    /// The CIDR of the resource.
    resource_cidr: ?[]const u8 = null,

    /// The compliance status of a resource. For more information on compliance
    /// statuses, see [Monitor CIDR usage by
    /// resource](https://docs.aws.amazon.com/vpc/latest/ipam/monitor-cidr-compliance-ipam.html) in the *Amazon VPC IPAM User Guide*.
    resource_compliance_status: ?IpamComplianceStatus = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The name of the resource.
    resource_name: ?[]const u8 = null,

    /// The overlap status of an IPAM resource. The overlap status tells you if the
    /// CIDR for a resource overlaps with another CIDR in the scope. For more
    /// information on overlap statuses, see [Monitor CIDR usage by
    /// resource](https://docs.aws.amazon.com/vpc/latest/ipam/monitor-cidr-compliance-ipam.html) in the *Amazon VPC IPAM User Guide*.
    resource_overlap_status: ?IpamOverlapStatus = null,

    /// The ID of the resource owner.
    resource_owner_id: ?[]const u8 = null,

    /// The Amazon Web Services Region of the resource.
    resource_region: ?[]const u8 = null,

    /// The type of the resource.
    resource_type: ?IpamAddressHistoryResourceType = null,

    /// Sampled end time of the resource-to-CIDR association within the IPAM scope.
    /// Changes are picked up in periodic snapshots, so the end time may have
    /// occurred before this specific time.
    sampled_end_time: ?i64 = null,

    /// Sampled start time of the resource-to-CIDR association within the IPAM
    /// scope. Changes are picked up in periodic snapshots, so the start time may
    /// have occurred before this specific time.
    sampled_start_time: ?i64 = null,

    /// The VPC ID of the resource.
    vpc_id: ?[]const u8 = null,
};
