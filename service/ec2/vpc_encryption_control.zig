const VpcEncryptionControlMode = @import("vpc_encryption_control_mode.zig").VpcEncryptionControlMode;
const VpcEncryptionControlExclusions = @import("vpc_encryption_control_exclusions.zig").VpcEncryptionControlExclusions;
const VpcEncryptionControlState = @import("vpc_encryption_control_state.zig").VpcEncryptionControlState;
const Tag = @import("tag.zig").Tag;

/// Describes the configuration and state of VPC encryption controls.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const VpcEncryptionControl = struct {
    /// The encryption mode for the VPC Encryption Control configuration.
    mode: ?VpcEncryptionControlMode = null,

    /// Information about resource exclusions for the VPC Encryption Control
    /// configuration.
    resource_exclusions: ?VpcEncryptionControlExclusions = null,

    /// The current state of the VPC Encryption Control configuration.
    state: ?VpcEncryptionControlState = null,

    /// A message providing additional information about the encryption control
    /// state.
    state_message: ?[]const u8 = null,

    /// The tags assigned to the VPC Encryption Control configuration.
    tags: ?[]const Tag = null,

    /// The ID of the VPC Encryption Control configuration.
    vpc_encryption_control_id: ?[]const u8 = null,

    /// The ID of the VPC associated with the encryption control configuration.
    vpc_id: ?[]const u8 = null,
};
