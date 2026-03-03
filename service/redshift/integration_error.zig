/// The error of an inbound integration.
pub const IntegrationError = struct {
    /// The error code of an inbound integration error.
    error_code: []const u8,

    /// The error message of an inbound integration error.
    error_message: ?[]const u8 = null,
};
