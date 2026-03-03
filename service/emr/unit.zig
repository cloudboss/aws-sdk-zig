const std = @import("std");

pub const Unit = enum {
    none,
    seconds,
    micro_seconds,
    milli_seconds,
    bytes,
    kilo_bytes,
    mega_bytes,
    giga_bytes,
    tera_bytes,
    bits,
    kilo_bits,
    mega_bits,
    giga_bits,
    tera_bits,
    percent,
    count,
    bytes_per_second,
    kilo_bytes_per_second,
    mega_bytes_per_second,
    giga_bytes_per_second,
    tera_bytes_per_second,
    bits_per_second,
    kilo_bits_per_second,
    mega_bits_per_second,
    giga_bits_per_second,
    tera_bits_per_second,
    count_per_second,

    pub const json_field_names = .{
        .none = "NONE",
        .seconds = "SECONDS",
        .micro_seconds = "MICRO_SECONDS",
        .milli_seconds = "MILLI_SECONDS",
        .bytes = "BYTES",
        .kilo_bytes = "KILO_BYTES",
        .mega_bytes = "MEGA_BYTES",
        .giga_bytes = "GIGA_BYTES",
        .tera_bytes = "TERA_BYTES",
        .bits = "BITS",
        .kilo_bits = "KILO_BITS",
        .mega_bits = "MEGA_BITS",
        .giga_bits = "GIGA_BITS",
        .tera_bits = "TERA_BITS",
        .percent = "PERCENT",
        .count = "COUNT",
        .bytes_per_second = "BYTES_PER_SECOND",
        .kilo_bytes_per_second = "KILO_BYTES_PER_SECOND",
        .mega_bytes_per_second = "MEGA_BYTES_PER_SECOND",
        .giga_bytes_per_second = "GIGA_BYTES_PER_SECOND",
        .tera_bytes_per_second = "TERA_BYTES_PER_SECOND",
        .bits_per_second = "BITS_PER_SECOND",
        .kilo_bits_per_second = "KILO_BITS_PER_SECOND",
        .mega_bits_per_second = "MEGA_BITS_PER_SECOND",
        .giga_bits_per_second = "GIGA_BITS_PER_SECOND",
        .tera_bits_per_second = "TERA_BITS_PER_SECOND",
        .count_per_second = "COUNT_PER_SECOND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .seconds => "SECONDS",
            .micro_seconds => "MICRO_SECONDS",
            .milli_seconds => "MILLI_SECONDS",
            .bytes => "BYTES",
            .kilo_bytes => "KILO_BYTES",
            .mega_bytes => "MEGA_BYTES",
            .giga_bytes => "GIGA_BYTES",
            .tera_bytes => "TERA_BYTES",
            .bits => "BITS",
            .kilo_bits => "KILO_BITS",
            .mega_bits => "MEGA_BITS",
            .giga_bits => "GIGA_BITS",
            .tera_bits => "TERA_BITS",
            .percent => "PERCENT",
            .count => "COUNT",
            .bytes_per_second => "BYTES_PER_SECOND",
            .kilo_bytes_per_second => "KILO_BYTES_PER_SECOND",
            .mega_bytes_per_second => "MEGA_BYTES_PER_SECOND",
            .giga_bytes_per_second => "GIGA_BYTES_PER_SECOND",
            .tera_bytes_per_second => "TERA_BYTES_PER_SECOND",
            .bits_per_second => "BITS_PER_SECOND",
            .kilo_bits_per_second => "KILO_BITS_PER_SECOND",
            .mega_bits_per_second => "MEGA_BITS_PER_SECOND",
            .giga_bits_per_second => "GIGA_BITS_PER_SECOND",
            .tera_bits_per_second => "TERA_BITS_PER_SECOND",
            .count_per_second => "COUNT_PER_SECOND",
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
