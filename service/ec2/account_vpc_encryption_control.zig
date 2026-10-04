const AccountVpcEncryptionControlExclusions = @import("account_vpc_encryption_control_exclusions.zig").AccountVpcEncryptionControlExclusions;
const ManagedBy = @import("managed_by.zig").ManagedBy;
const AccountVpcEncryptionControlMode = @import("account_vpc_encryption_control_mode.zig").AccountVpcEncryptionControlMode;
const AccountVpcEncryptionControlState = @import("account_vpc_encryption_control_state.zig").AccountVpcEncryptionControlState;

/// Describes the account-level VPC Encryption Control configuration, including
/// its mode, state, and exclusions.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
pub const AccountVpcEncryptionControl = struct {
    /// Information about the traffic exclusions for the account-level VPC
    /// Encryption Control configuration.
    exclusions: ?AccountVpcEncryptionControlExclusions = null,

    /// The date and time when the account-level VPC Encryption Control
    /// configuration was last updated.
    last_update_timestamp: ?i64 = null,

    /// The entity that manages the account-level VPC Encryption Control
    /// configuration.
    managed_by: ?ManagedBy = null,

    /// The encryption mode for the account-level VPC Encryption Control
    /// configuration.
    mode: ?AccountVpcEncryptionControlMode = null,

    /// The current state of the account-level VPC Encryption Control configuration.
    state: ?AccountVpcEncryptionControlState = null,
};
