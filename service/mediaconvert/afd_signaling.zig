const std = @import("std");

/// This setting only applies to H.264, H.265, and MPEG2 outputs. Use Insert AFD
/// signaling to specify whether the service includes AFD values in the output
/// video data and what those values are. * Choose None to remove all AFD values
/// from this output. * Choose Fixed to ignore input AFD values and instead
/// encode the value specified in the job. * Choose Auto to calculate output AFD
/// values based on the input AFD scaler data.
pub const AfdSignaling = enum {
    none,
    auto,
    fixed,

    pub const json_field_names = .{
        .none = "NONE",
        .auto = "AUTO",
        .fixed = "FIXED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .auto => "AUTO",
            .fixed => "FIXED",
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
