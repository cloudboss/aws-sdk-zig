const RtmpAdMarkers = @import("rtmp_ad_markers.zig").RtmpAdMarkers;
const AuthenticationScheme = @import("authentication_scheme.zig").AuthenticationScheme;
const RtmpCacheFullBehavior = @import("rtmp_cache_full_behavior.zig").RtmpCacheFullBehavior;
const RtmpCaptionData = @import("rtmp_caption_data.zig").RtmpCaptionData;
const IncludeFillerNalUnits = @import("include_filler_nal_units.zig").IncludeFillerNalUnits;
const InputLossActionForRtmpOut = @import("input_loss_action_for_rtmp_out.zig").InputLossActionForRtmpOut;

/// Rtmp Group Settings
pub const RtmpGroupSettings = struct {
    /// Choose the ad marker type for this output group. MediaLive will create a
    /// message based on the content of each SCTE-35 message, format it for that
    /// marker type, and insert it in the datastream.
    ad_markers: ?[]const RtmpAdMarkers,

    /// Authentication scheme to use when connecting with CDN
    authentication_scheme: ?AuthenticationScheme,

    /// Controls behavior when content cache fills up. If remote origin server
    /// stalls the RTMP connection and does not accept content fast enough the
    /// 'Media Cache' will fill up. When the cache reaches the duration specified by
    /// cacheLength the cache will stop accepting new content. If set to
    /// disconnectImmediately, the RTMP output will force a disconnect. Clear the
    /// media cache, and reconnect after restartDelay seconds. If set to
    /// waitForServer, the RTMP output will wait up to 5 minutes to allow the origin
    /// server to begin accepting data again.
    cache_full_behavior: ?RtmpCacheFullBehavior,

    /// Cache length, in seconds, is used to calculate buffer size.
    cache_length: ?i32,

    /// Controls the types of data that passes to onCaptionInfo outputs. If set to
    /// 'all' then 608 and 708 carried DTVCC data will be passed. If set to
    /// 'field1AndField2608' then DTVCC data will be stripped out, but 608 data from
    /// both fields will be passed. If set to 'field1608' then only the data carried
    /// in 608 from field 1 video will be passed.
    caption_data: ?RtmpCaptionData,

    /// Applies only when the rate control mode (in the codec settings) is CBR
    /// (constant bit rate). Controls whether the RTMP output stream is padded (with
    /// FILL NAL units) in order to achieve a constant bit rate that is truly
    /// constant. When there is no padding, the bandwidth varies (up to the bitrate
    /// value in the codec settings). We recommend that you choose Auto.
    include_filler_nal_units: ?IncludeFillerNalUnits,

    /// Controls the behavior of this RTMP group if input becomes unavailable.
    ///
    /// - emitOutput: Emit a slate until input returns.
    /// - pauseOutput: Stop transmitting data until input returns. This does not
    /// close the underlying RTMP connection.
    input_loss_action: ?InputLossActionForRtmpOut,

    /// If a streaming output fails, number of seconds to wait until a restart is
    /// initiated. A value of 0 means never restart.
    restart_delay: ?i32,

    pub const json_field_names = .{
        .ad_markers = "AdMarkers",
        .authentication_scheme = "AuthenticationScheme",
        .cache_full_behavior = "CacheFullBehavior",
        .cache_length = "CacheLength",
        .caption_data = "CaptionData",
        .include_filler_nal_units = "IncludeFillerNalUnits",
        .input_loss_action = "InputLossAction",
        .restart_delay = "RestartDelay",
    };
};
