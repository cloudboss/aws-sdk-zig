const InternetGatewayExclusionMode = @import("internet_gateway_exclusion_mode.zig").InternetGatewayExclusionMode;
const VpcBlockPublicAccessExclusionState = @import("vpc_block_public_access_exclusion_state.zig").VpcBlockPublicAccessExclusionState;
const Tag = @import("tag.zig").Tag;

/// A VPC BPA exclusion is a mode that can be applied to a single VPC or subnet
/// that exempts it from the account’s BPA mode and will allow bidirectional or
/// egress-only access. You can create BPA exclusions for VPCs and subnets even
/// when BPA is not enabled on the account to ensure that there is no traffic
/// disruption to the exclusions when VPC BPA is turned on. To learn more about
/// VPC BPA, see [Block public access to VPCs and
/// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
pub const VpcBlockPublicAccessExclusion = struct {
    /// When the exclusion was created.
    creation_timestamp: ?i64 = null,

    /// When the exclusion was deleted.
    deletion_timestamp: ?i64 = null,

    /// The ID of the exclusion.
    exclusion_id: ?[]const u8 = null,

    /// The exclusion mode for internet gateway traffic.
    ///
    /// * `allow-bidirectional`: Allow all internet traffic to and from the excluded
    ///   VPCs and subnets.
    ///
    /// * `allow-egress`: Allow outbound internet traffic from the excluded VPCs and
    ///   subnets. Block inbound internet traffic to the excluded VPCs and subnets.
    ///   Only applies when VPC Block Public Access is set to Bidirectional.
    internet_gateway_exclusion_mode: ?InternetGatewayExclusionMode = null,

    /// When the exclusion was last updated.
    last_update_timestamp: ?i64 = null,

    /// The reason for the current exclusion state.
    reason: ?[]const u8 = null,

    /// The ARN of the exclusion.
    resource_arn: ?[]const u8 = null,

    /// The state of the exclusion.
    state: ?VpcBlockPublicAccessExclusionState = null,

    /// `tag` - The key/value combination of a tag assigned to the resource. Use the
    /// tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    tags: ?[]const Tag = null,
};
