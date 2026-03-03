/// Add an operating Region to an IPAM. Operating Regions are Amazon Web
/// Services Regions where the IPAM is allowed to manage IP address CIDRs. IPAM
/// only discovers and monitors resources in the Amazon Web Services Regions you
/// select as operating Regions.
///
/// For more information about operating Regions, see [Create an
/// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html) in the
/// *Amazon VPC IPAM User Guide*.
pub const AddIpamOperatingRegion = struct {
    /// The name of the operating Region.
    region_name: ?[]const u8 = null,
};
