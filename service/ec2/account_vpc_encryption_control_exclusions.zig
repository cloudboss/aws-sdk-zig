const VpcEncryptionControlExclusionState = @import("vpc_encryption_control_exclusion_state.zig").VpcEncryptionControlExclusionState;

/// Describes the exclusion configurations for the various resource types in the
/// account-level VPC Encryption Control configuration.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const AccountVpcEncryptionControlExclusions = struct {
    /// The exclusion configuration for egress-only internet gateway resource.
    egress_only_internet_gateway: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for Elastic File System service.
    elastic_file_system: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for internet gateway resource.
    internet_gateway: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for Lambda service.
    lambda: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for NAT gateway resource.
    nat_gateway: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for virtual private gateway resource.
    virtual_private_gateway: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for VPC Lattice service.
    vpc_lattice: ?VpcEncryptionControlExclusionState = null,

    /// The exclusion configuration for VPC peering connection resource.
    vpc_peering: ?VpcEncryptionControlExclusionState = null,
};
