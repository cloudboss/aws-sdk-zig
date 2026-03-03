const std = @import("std");

/// The different types of inputs that AWS Elemental MediaLive supports.
pub const InputType = enum {
    udp_push,
    rtp_push,
    rtmp_push,
    rtmp_pull,
    url_pull,
    mp4_file,
    mediaconnect,
    input_device,
    aws_cdi,
    ts_file,
    srt_caller,
    multicast,
    smpte_2110_receiver_group,
    sdi,
    mediaconnect_router,
    srt_listener,

    pub const json_field_names = .{
        .udp_push = "UDP_PUSH",
        .rtp_push = "RTP_PUSH",
        .rtmp_push = "RTMP_PUSH",
        .rtmp_pull = "RTMP_PULL",
        .url_pull = "URL_PULL",
        .mp4_file = "MP4_FILE",
        .mediaconnect = "MEDIACONNECT",
        .input_device = "INPUT_DEVICE",
        .aws_cdi = "AWS_CDI",
        .ts_file = "TS_FILE",
        .srt_caller = "SRT_CALLER",
        .multicast = "MULTICAST",
        .smpte_2110_receiver_group = "SMPTE_2110_RECEIVER_GROUP",
        .sdi = "SDI",
        .mediaconnect_router = "MEDIACONNECT_ROUTER",
        .srt_listener = "SRT_LISTENER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .udp_push => "UDP_PUSH",
            .rtp_push => "RTP_PUSH",
            .rtmp_push => "RTMP_PUSH",
            .rtmp_pull => "RTMP_PULL",
            .url_pull => "URL_PULL",
            .mp4_file => "MP4_FILE",
            .mediaconnect => "MEDIACONNECT",
            .input_device => "INPUT_DEVICE",
            .aws_cdi => "AWS_CDI",
            .ts_file => "TS_FILE",
            .srt_caller => "SRT_CALLER",
            .multicast => "MULTICAST",
            .smpte_2110_receiver_group => "SMPTE_2110_RECEIVER_GROUP",
            .sdi => "SDI",
            .mediaconnect_router => "MEDIACONNECT_ROUTER",
            .srt_listener => "SRT_LISTENER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
