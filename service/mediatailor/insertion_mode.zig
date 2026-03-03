const std = @import("std");

/// Insertion Mode controls whether players can use stitched or guided ad
/// insertion.
pub const InsertionMode = enum {
    stitched_only,
    player_select,

    pub const json_field_names = .{
        .stitched_only = "STITCHED_ONLY",
        .player_select = "PLAYER_SELECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stitched_only => "STITCHED_ONLY",
            .player_select => "PLAYER_SELECT",
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
