const ImageConfigError = @import("image_config_error.zig").ImageConfigError;
const ImageConfig = @import("image_config.zig").ImageConfig;

/// Response to a `GetFunctionConfiguration` request.
pub const ImageConfigResponse = struct {
    /// Error response to `GetFunctionConfiguration`.
    @"error": ?ImageConfigError,

    /// Configuration values that override the container image Dockerfile.
    image_config: ?ImageConfig,
};
