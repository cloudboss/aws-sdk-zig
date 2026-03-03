const std = @import("std");

/// Set Embedded timecode override to Use MDPM when your AVCHD input contains
/// timecode tag data in the Modified Digital Video Pack Metadata. When you do,
/// we recommend you also set Timecode source to Embedded. Leave Embedded
/// timecode override blank, or set to None, when your input does not contain
/// MDPM timecode.
pub const EmbeddedTimecodeOverride = enum {
    none,
    use_mdpm,

    pub const json_field_names = .{
        .none = "NONE",
        .use_mdpm = "USE_MDPM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .use_mdpm => "USE_MDPM",
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
