const std = @import("std");

pub const AlgorithmNameGeoMosaic = enum {
    /// NEAR
    near,
    /// BILINEAR
    bilinear,
    /// CUBIC
    cubic,
    /// CUBICSPLINE
    cubicspline,
    /// LANCZOS
    lanczos,
    /// AVERAGE
    average,
    /// RMS
    rms,
    /// MODE
    mode,
    /// MAX
    max,
    /// MIN
    min,
    /// MED
    med,
    /// Q1
    q1,
    /// Q3
    q3,
    /// SUM
    sum,

    pub const json_field_names = .{
        .near = "NEAR",
        .bilinear = "BILINEAR",
        .cubic = "CUBIC",
        .cubicspline = "CUBICSPLINE",
        .lanczos = "LANCZOS",
        .average = "AVERAGE",
        .rms = "RMS",
        .mode = "MODE",
        .max = "MAX",
        .min = "MIN",
        .med = "MED",
        .q1 = "Q1",
        .q3 = "Q3",
        .sum = "SUM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .near => "NEAR",
            .bilinear => "BILINEAR",
            .cubic => "CUBIC",
            .cubicspline => "CUBICSPLINE",
            .lanczos => "LANCZOS",
            .average => "AVERAGE",
            .rms => "RMS",
            .mode => "MODE",
            .max => "MAX",
            .min => "MIN",
            .med => "MED",
            .q1 => "Q1",
            .q3 => "Q3",
            .sum => "SUM",
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
