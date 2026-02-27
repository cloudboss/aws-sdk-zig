const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides information about a set of featured results that couldn't be
/// removed from an index by the
/// [BatchDeleteFeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchDeleteFeaturedResultsSet.html) API.
pub const BatchDeleteFeaturedResultsSetError = struct {
    /// The error code for why the set of featured results couldn't be removed
    /// from the index.
    error_code: ErrorCode,

    /// An explanation for why the set of featured results couldn't be removed
    /// from the index.
    error_message: []const u8,

    /// The identifier of the set of featured results that couldn't be removed
    /// from the index.
    id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .id = "Id",
    };
};
