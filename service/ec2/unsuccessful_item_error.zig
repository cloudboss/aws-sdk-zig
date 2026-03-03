/// Information about the error that occurred. For more information about
/// errors, see [Error
/// codes](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html).
pub const UnsuccessfulItemError = struct {
    /// The error code.
    code: ?[]const u8 = null,

    /// The error message accompanying the error code.
    message: ?[]const u8 = null,
};
