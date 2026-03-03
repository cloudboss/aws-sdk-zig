const std = @import("std");

pub const SampleType = enum {
    cpu,
    memory,
    threads,
    rx_rate,
    tx_rate,
    rx,
    tx,
    native_frames,
    native_fps,
    native_min_drawtime,
    native_avg_drawtime,
    native_max_drawtime,
    opengl_frames,
    opengl_fps,
    opengl_min_drawtime,
    opengl_avg_drawtime,
    opengl_max_drawtime,

    pub const json_field_names = .{
        .cpu = "CPU",
        .memory = "MEMORY",
        .threads = "THREADS",
        .rx_rate = "RX_RATE",
        .tx_rate = "TX_RATE",
        .rx = "RX",
        .tx = "TX",
        .native_frames = "NATIVE_FRAMES",
        .native_fps = "NATIVE_FPS",
        .native_min_drawtime = "NATIVE_MIN_DRAWTIME",
        .native_avg_drawtime = "NATIVE_AVG_DRAWTIME",
        .native_max_drawtime = "NATIVE_MAX_DRAWTIME",
        .opengl_frames = "OPENGL_FRAMES",
        .opengl_fps = "OPENGL_FPS",
        .opengl_min_drawtime = "OPENGL_MIN_DRAWTIME",
        .opengl_avg_drawtime = "OPENGL_AVG_DRAWTIME",
        .opengl_max_drawtime = "OPENGL_MAX_DRAWTIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu => "CPU",
            .memory => "MEMORY",
            .threads => "THREADS",
            .rx_rate => "RX_RATE",
            .tx_rate => "TX_RATE",
            .rx => "RX",
            .tx => "TX",
            .native_frames => "NATIVE_FRAMES",
            .native_fps => "NATIVE_FPS",
            .native_min_drawtime => "NATIVE_MIN_DRAWTIME",
            .native_avg_drawtime => "NATIVE_AVG_DRAWTIME",
            .native_max_drawtime => "NATIVE_MAX_DRAWTIME",
            .opengl_frames => "OPENGL_FRAMES",
            .opengl_fps => "OPENGL_FPS",
            .opengl_min_drawtime => "OPENGL_MIN_DRAWTIME",
            .opengl_avg_drawtime => "OPENGL_AVG_DRAWTIME",
            .opengl_max_drawtime => "OPENGL_MAX_DRAWTIME",
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
