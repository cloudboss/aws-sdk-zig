const std = @import("std");

pub const GenericDataRelationshipType = enum {
    has_many,
    has_one,
    belongs_to,

    pub const json_field_names = .{
        .has_many = "HAS_MANY",
        .has_one = "HAS_ONE",
        .belongs_to = "BELONGS_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .has_many => "HAS_MANY",
            .has_one => "HAS_ONE",
            .belongs_to => "BELONGS_TO",
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
