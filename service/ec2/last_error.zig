/// The last error that occurred for a VPC endpoint.
pub const LastError = struct {
    /// The error code for the VPC endpoint error.
    code: ?[]const u8,

    /// The error message for the VPC endpoint error.
    message: ?[]const u8,
};
