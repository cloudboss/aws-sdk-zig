const VpcEncryptionControlExclusionState = @import("vpc_encryption_control_exclusion_state.zig").VpcEncryptionControlExclusionState;

/// Describes an exclusion configuration for VPC Encryption Control.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const VpcEncryptionControlExclusion = struct {
    /// The current state of the exclusion configuration.
    state: ?VpcEncryptionControlExclusionState,

    /// A message providing additional information about the exclusion state.
    state_message: ?[]const u8,
};
