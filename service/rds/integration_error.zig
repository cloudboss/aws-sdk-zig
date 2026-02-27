/// An error associated with a zero-ETL integration with Amazon Redshift.
pub const IntegrationError = struct {
    /// The error code associated with the integration.
    error_code: []const u8,

    /// A message explaining the error.
    error_message: ?[]const u8,
};
