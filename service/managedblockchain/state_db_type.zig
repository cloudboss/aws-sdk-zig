const std = @import("std");

pub const StateDBType = enum {
    level_db,
    couch_db,

    pub const json_field_names = .{
        .level_db = "LevelDB",
        .couch_db = "CouchDB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .level_db => "LevelDB",
            .couch_db => "CouchDB",
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
