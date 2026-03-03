/// Describes a version of an IPAM prefix list resolver.
///
/// Each version is a snapshot of what CIDRs matched your rules at that moment
/// in time. The version number increments every time the CIDR list
/// changes due to infrastructure changes.
///
/// **Version example:**
///
/// **Initial State (Version 1)**
///
/// Production environment:
///
/// * vpc-prod-web (10.1.0.0/16) - tagged env=prod
///
/// * vpc-prod-db (10.2.0.0/16) - tagged env=prod
///
/// Resolver rule: Include all VPCs tagged env=prod
///
/// **Version 1 CIDRs:** 10.1.0.0/16, 10.2.0.0/16
///
/// **Infrastructure Change (Version 2)**
///
/// New VPC added:
///
/// * vpc-prod-api (10.3.0.0/16) - tagged env=prod
///
/// IPAM automatically detects the change and creates a new version.
///
/// **Version 2 CIDRs:** 10.1.0.0/16, 10.2.0.0/16, 10.3.0.0/16
pub const IpamPrefixListResolverVersion = struct {
    /// The version number of the IPAM prefix list resolver.
    ///
    /// Each version is a snapshot of what CIDRs matched your rules at that moment
    /// in time. The version number increments every time the CIDR list
    /// changes due to infrastructure changes.
    version: ?i64 = null,
};
