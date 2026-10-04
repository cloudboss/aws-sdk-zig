const std = @import("std");

/// Use Profile to set the MPEG-2 profile for the video output.
pub const Mpeg2CodecProfile = enum {
    main,
    profile_422,

    pub const json_field_names = .{
        .main = "MAIN",
        .profile_422 = "PROFILE_422",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .main => "MAIN",
            .profile_422 => "PROFILE_422",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
