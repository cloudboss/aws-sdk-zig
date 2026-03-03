const std = @import("std");

pub const Protocol = enum {
    zixi_push,
    rtp_fec,
    rtp,
    zixi_pull,
    rist,
    st_2110_jpegxs,
    cdi,
    srt_listener,
    srt_caller,
    fujitsu_qos,
    udp,
    ndi_speed_hq,

    pub const json_field_names = .{
        .zixi_push = "zixi-push",
        .rtp_fec = "rtp-fec",
        .rtp = "rtp",
        .zixi_pull = "zixi-pull",
        .rist = "rist",
        .st_2110_jpegxs = "st2110-jpegxs",
        .cdi = "cdi",
        .srt_listener = "srt-listener",
        .srt_caller = "srt-caller",
        .fujitsu_qos = "fujitsu-qos",
        .udp = "udp",
        .ndi_speed_hq = "ndi-speed-hq",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zixi_push => "zixi-push",
            .rtp_fec => "rtp-fec",
            .rtp => "rtp",
            .zixi_pull => "zixi-pull",
            .rist => "rist",
            .st_2110_jpegxs => "st2110-jpegxs",
            .cdi => "cdi",
            .srt_listener => "srt-listener",
            .srt_caller => "srt-caller",
            .fujitsu_qos => "fujitsu-qos",
            .udp => "udp",
            .ndi_speed_hq => "ndi-speed-hq",
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
