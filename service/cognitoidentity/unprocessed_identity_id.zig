const ErrorCode = @import("error_code.zig").ErrorCode;

/// An array of UnprocessedIdentityId objects, each of which contains an
/// ErrorCode and
/// IdentityId.
pub const UnprocessedIdentityId = struct {
    /// The error code indicating the type of error that occurred.
    error_code: ?ErrorCode,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .identity_id = "IdentityId",
    };
};
