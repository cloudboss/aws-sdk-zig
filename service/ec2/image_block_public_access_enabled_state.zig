const std = @import("std");

pub const ImageBlockPublicAccessEnabledState = enum {
    block_new_sharing,

    pub const json_field_names = .{
        .block_new_sharing = "block-new-sharing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .block_new_sharing => "block-new-sharing",
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
