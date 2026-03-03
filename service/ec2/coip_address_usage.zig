/// Describes address usage for a customer-owned address pool.
pub const CoipAddressUsage = struct {
    /// The allocation ID of the address.
    allocation_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services service.
    aws_service: ?[]const u8 = null,

    /// The customer-owned IP address.
    co_ip: ?[]const u8 = null,
};
