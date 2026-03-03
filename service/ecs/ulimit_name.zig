const std = @import("std");

pub const UlimitName = enum {
    core,
    cpu,
    data,
    fsize,
    locks,
    memlock,
    msgqueue,
    nice,
    nofile,
    nproc,
    rss,
    rtprio,
    rttime,
    sigpending,
    stack,

    pub const json_field_names = .{
        .core = "core",
        .cpu = "cpu",
        .data = "data",
        .fsize = "fsize",
        .locks = "locks",
        .memlock = "memlock",
        .msgqueue = "msgqueue",
        .nice = "nice",
        .nofile = "nofile",
        .nproc = "nproc",
        .rss = "rss",
        .rtprio = "rtprio",
        .rttime = "rttime",
        .sigpending = "sigpending",
        .stack = "stack",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .core => "core",
            .cpu => "cpu",
            .data => "data",
            .fsize => "fsize",
            .locks => "locks",
            .memlock => "memlock",
            .msgqueue => "msgqueue",
            .nice => "nice",
            .nofile => "nofile",
            .nproc => "nproc",
            .rss => "rss",
            .rtprio => "rtprio",
            .rttime => "rttime",
            .sigpending => "sigpending",
            .stack => "stack",
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
