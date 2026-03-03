const std = @import("std");

pub const Select = enum {
    all_attributes,
    all_projected_attributes,
    specific_attributes,
    count,

    pub const json_field_names = .{
        .all_attributes = "ALL_ATTRIBUTES",
        .all_projected_attributes = "ALL_PROJECTED_ATTRIBUTES",
        .specific_attributes = "SPECIFIC_ATTRIBUTES",
        .count = "COUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_attributes => "ALL_ATTRIBUTES",
            .all_projected_attributes => "ALL_PROJECTED_ATTRIBUTES",
            .specific_attributes => "SPECIFIC_ATTRIBUTES",
            .count => "COUNT",
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
