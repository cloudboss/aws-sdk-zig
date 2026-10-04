const std = @import("std");

pub const TopicUserExperienceVersion = enum {
    legacy,
    new_reader_experience,

    pub const json_field_names = .{
        .legacy = "LEGACY",
        .new_reader_experience = "NEW_READER_EXPERIENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .legacy => "LEGACY",
            .new_reader_experience => "NEW_READER_EXPERIENCE",
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
