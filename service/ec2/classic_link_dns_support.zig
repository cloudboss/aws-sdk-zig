/// Deprecated.
///
/// Describes the ClassicLink DNS support status of a VPC.
pub const ClassicLinkDnsSupport = struct {
    /// Indicates whether ClassicLink DNS support is enabled for the VPC.
    classic_link_dns_supported: ?bool,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};
