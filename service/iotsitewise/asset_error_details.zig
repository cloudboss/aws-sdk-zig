const AssetErrorCode = @import("asset_error_code.zig").AssetErrorCode;

/// Contains error details for the requested associate project asset action.
pub const AssetErrorDetails = struct {
    /// The ID of the asset, in UUID format.
    asset_id: []const u8,

    /// The error code.
    code: AssetErrorCode,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .code = "code",
        .message = "message",
    };
};
