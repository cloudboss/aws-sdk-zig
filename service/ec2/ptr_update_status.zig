/// The status of an updated pointer (PTR) record for an Elastic IP address.
pub const PtrUpdateStatus = struct {
    /// The reason for the PTR record update.
    reason: ?[]const u8,

    /// The status of the PTR record update.
    status: ?[]const u8,

    /// The value for the PTR record update.
    value: ?[]const u8,
};
