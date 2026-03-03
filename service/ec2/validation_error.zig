/// The error code and error message that is returned for a parameter or
/// parameter
/// combination that is not valid when a new launch template or new version of a
/// launch
/// template is created.
pub const ValidationError = struct {
    /// The error code that indicates why the parameter or parameter combination is
    /// not valid.
    /// For more information about error codes, see [Error
    /// codes](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html).
    code: ?[]const u8 = null,

    /// The error message that describes why the parameter or parameter combination
    /// is not
    /// valid. For more information about error messages, see [Error
    /// codes](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html).
    message: ?[]const u8 = null,
};
