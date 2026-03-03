const std = @import("std");

/// Rtmp Caption Data
pub const RtmpCaptionData = enum {
    all,
    field1_608,
    field1_and_field2_608,

    pub const json_field_names = .{
        .all = "ALL",
        .field1_608 = "FIELD1_608",
        .field1_and_field2_608 = "FIELD1_AND_FIELD2_608",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .field1_608 => "FIELD1_608",
            .field1_and_field2_608 => "FIELD1_AND_FIELD2_608",
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
