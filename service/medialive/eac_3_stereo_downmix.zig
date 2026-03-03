const std = @import("std");

/// Eac3 Stereo Downmix
pub const Eac3StereoDownmix = enum {
    dpl2,
    lo_ro,
    lt_rt,
    not_indicated,

    pub const json_field_names = .{
        .dpl2 = "DPL2",
        .lo_ro = "LO_RO",
        .lt_rt = "LT_RT",
        .not_indicated = "NOT_INDICATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dpl2 => "DPL2",
            .lo_ro => "LO_RO",
            .lt_rt => "LT_RT",
            .not_indicated => "NOT_INDICATED",
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
