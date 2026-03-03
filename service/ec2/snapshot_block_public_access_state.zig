const std = @import("std");

pub const SnapshotBlockPublicAccessState = enum {
    block_all_sharing,
    block_new_sharing,
    unblocked,

    pub const json_field_names = .{
        .block_all_sharing = "block-all-sharing",
        .block_new_sharing = "block-new-sharing",
        .unblocked = "unblocked",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .block_all_sharing => "block-all-sharing",
            .block_new_sharing => "block-new-sharing",
            .unblocked => "unblocked",
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
