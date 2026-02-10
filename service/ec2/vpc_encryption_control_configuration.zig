const VpcEncryptionControlExclusionStateInput = @import("vpc_encryption_control_exclusion_state_input.zig").VpcEncryptionControlExclusionStateInput;
const VpcEncryptionControlMode = @import("vpc_encryption_control_mode.zig").VpcEncryptionControlMode;

/// Describes the configuration settings for VPC Encryption Control.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const VpcEncryptionControlConfiguration = struct {
    /// Specifies whether to exclude egress-only internet gateway traffic from
    /// encryption enforcement.
    egress_only_internet_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// Specifies whether to exclude Elastic File System traffic from encryption
    /// enforcement.
    elastic_file_system_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// Specifies whether to exclude internet gateway traffic from encryption
    /// enforcement.
    internet_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// Specifies whether to exclude Lambda function traffic from encryption
    /// enforcement.
    lambda_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// The encryption mode for the VPC Encryption Control configuration.
    mode: VpcEncryptionControlMode,

    /// Specifies whether to exclude NAT gateway traffic from encryption
    /// enforcement.
    nat_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// Specifies whether to exclude virtual private gateway traffic from encryption
    /// enforcement.
    virtual_private_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// Specifies whether to exclude VPC Lattice traffic from encryption
    /// enforcement.
    vpc_lattice_exclusion: ?VpcEncryptionControlExclusionStateInput,

    /// Specifies whether to exclude VPC peering connection traffic from encryption
    /// enforcement.
    vpc_peering_exclusion: ?VpcEncryptionControlExclusionStateInput,
};
