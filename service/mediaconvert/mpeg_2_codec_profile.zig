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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
