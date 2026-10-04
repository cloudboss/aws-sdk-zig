const Resolution = @import("resolution.zig").Resolution;

/// The virtual monitor settings for a stream session, including the resolution.
/// If not specified, the stream session uses the default resolution of 1920 ×
/// 1080.
pub const DisplayConfiguration = struct {
    /// The resolution to apply to the stream session's virtual monitor. When
    /// specified, this value overrides the default resolution of 1920 × 1080.
    resolution: ?Resolution = null,

    pub const json_field_names = .{
        .resolution = "Resolution",
    };
};
