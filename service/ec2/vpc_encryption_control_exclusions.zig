const VpcEncryptionControlExclusion = @import("vpc_encryption_control_exclusion.zig").VpcEncryptionControlExclusion;

/// Describes the exclusion configurations for various resource types in VPC
/// Encryption Control.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const VpcEncryptionControlExclusions = struct {
    /// The exclusion configuration for egress-only internet gateway traffic.
    egress_only_internet_gateway: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for Elastic File System traffic.
    elastic_file_system: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for internet gateway traffic.
    internet_gateway: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for Lambda function traffic.
    lambda: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for NAT gateway traffic.
    nat_gateway: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for virtual private gateway traffic.
    virtual_private_gateway: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for VPC Lattice traffic.
    vpc_lattice: ?VpcEncryptionControlExclusion,

    /// The exclusion configuration for VPC peering connection traffic.
    vpc_peering: ?VpcEncryptionControlExclusion,
};
