const AddressTransferStatus = @import("address_transfer_status.zig").AddressTransferStatus;

/// Details on the Elastic IP address transfer. For more information, see
/// [Transfer Elastic IP
/// addresses](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-eips.html#transfer-EIPs-intro) in the *Amazon VPC User Guide*.
pub const AddressTransfer = struct {
    /// The Elastic IP address transfer status.
    address_transfer_status: ?AddressTransferStatus = null,

    /// The allocation ID of an Elastic IP address.
    allocation_id: ?[]const u8 = null,

    /// The Elastic IP address being transferred.
    public_ip: ?[]const u8 = null,

    /// The ID of the account that you want to transfer the Elastic IP address to.
    transfer_account_id: ?[]const u8 = null,

    /// The timestamp when the Elastic IP address transfer was accepted.
    transfer_offer_accepted_timestamp: ?i64 = null,

    /// The timestamp when the Elastic IP address transfer expired. When the source
    /// account starts
    /// the transfer, the transfer account has seven hours to allocate the Elastic
    /// IP address to
    /// complete the transfer, or the Elastic IP address will return to its original
    /// owner.
    transfer_offer_expiration_timestamp: ?i64 = null,
};
