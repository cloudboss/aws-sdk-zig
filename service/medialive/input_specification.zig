const InputCodec = @import("input_codec.zig").InputCodec;
const InputMaximumBitrate = @import("input_maximum_bitrate.zig").InputMaximumBitrate;
const InputResolution = @import("input_resolution.zig").InputResolution;

/// Placeholder documentation for InputSpecification
pub const InputSpecification = struct {
    /// Input codec
    codec: ?InputCodec = null,

    /// Maximum input bitrate, categorized coarsely
    maximum_bitrate: ?InputMaximumBitrate = null,

    /// Input resolution, categorized coarsely
    resolution: ?InputResolution = null,

    pub const json_field_names = .{
        .codec = "Codec",
        .maximum_bitrate = "MaximumBitrate",
        .resolution = "Resolution",
    };
};
