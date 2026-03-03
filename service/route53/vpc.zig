const VPCRegion = @import("vpc_region.zig").VPCRegion;

/// (Private hosted zones only) A complex type that contains information about
/// an Amazon VPC.
///
/// If you associate a private hosted zone with an Amazon VPC when you make a
/// [CreateHostedZone](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateHostedZone.html)
/// request, the following parameters are also required.
pub const VPC = struct {
    vpc_id: ?[]const u8 = null,

    /// (Private hosted zones only) The region that an Amazon VPC was created
    /// in.
    vpc_region: ?VPCRegion = null,
};
