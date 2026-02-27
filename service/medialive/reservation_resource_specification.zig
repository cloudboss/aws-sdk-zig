const ChannelClass = @import("channel_class.zig").ChannelClass;
const ReservationCodec = @import("reservation_codec.zig").ReservationCodec;
const ReservationMaximumBitrate = @import("reservation_maximum_bitrate.zig").ReservationMaximumBitrate;
const ReservationMaximumFramerate = @import("reservation_maximum_framerate.zig").ReservationMaximumFramerate;
const ReservationResolution = @import("reservation_resolution.zig").ReservationResolution;
const ReservationResourceType = @import("reservation_resource_type.zig").ReservationResourceType;
const ReservationSpecialFeature = @import("reservation_special_feature.zig").ReservationSpecialFeature;
const ReservationVideoQuality = @import("reservation_video_quality.zig").ReservationVideoQuality;

/// Resource configuration (codec, resolution, bitrate, ...)
pub const ReservationResourceSpecification = struct {
    /// Channel class, e.g. 'STANDARD'
    channel_class: ?ChannelClass,

    /// Codec, e.g. 'AVC'
    codec: ?ReservationCodec,

    /// Maximum bitrate, e.g. 'MAX_20_MBPS'
    maximum_bitrate: ?ReservationMaximumBitrate,

    /// Maximum framerate, e.g. 'MAX_30_FPS' (Outputs only)
    maximum_framerate: ?ReservationMaximumFramerate,

    /// Resolution, e.g. 'HD'
    resolution: ?ReservationResolution,

    /// Resource type, 'INPUT', 'OUTPUT', 'MULTIPLEX', or 'CHANNEL'
    resource_type: ?ReservationResourceType,

    /// Special feature, e.g. 'AUDIO_NORMALIZATION' (Channels only)
    special_feature: ?ReservationSpecialFeature,

    /// Video quality, e.g. 'STANDARD' (Outputs only)
    video_quality: ?ReservationVideoQuality,

    pub const json_field_names = .{
        .channel_class = "ChannelClass",
        .codec = "Codec",
        .maximum_bitrate = "MaximumBitrate",
        .maximum_framerate = "MaximumFramerate",
        .resolution = "Resolution",
        .resource_type = "ResourceType",
        .special_feature = "SpecialFeature",
        .video_quality = "VideoQuality",
    };
};
