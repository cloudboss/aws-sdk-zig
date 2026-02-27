const SceneErrorCode = @import("scene_error_code.zig").SceneErrorCode;

/// The scene error.
pub const SceneError = struct {
    /// The SceneError code.
    code: ?SceneErrorCode,

    /// The SceneError message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
