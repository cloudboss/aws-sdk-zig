const PtrUpdateStatus = @import("ptr_update_status.zig").PtrUpdateStatus;

/// The attributes associated with an Elastic IP address.
pub const AddressAttribute = struct {
    /// [EC2-VPC] The allocation ID.
    allocation_id: ?[]const u8,

    /// The pointer (PTR) record for the IP address.
    ptr_record: ?[]const u8,

    /// The updated PTR record for the IP address.
    ptr_record_update: ?PtrUpdateStatus,

    /// The public IP address.
    public_ip: ?[]const u8,
};
