/// Describes an error experienced when getting recommendations.
///
/// For example, an error is returned if you request recommendations for an
/// unsupported
/// Auto Scaling group, or if you request recommendations for an instance of an
/// unsupported instance family.
pub const GetRecommendationError = struct {
    /// The error code.
    code: ?[]const u8 = null,

    /// The ID of the error.
    identifier: ?[]const u8 = null,

    /// The message, or reason, for the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .identifier = "identifier",
        .message = "message",
    };
};
