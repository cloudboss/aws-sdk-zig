const std = @import("std");

pub const SideOfStreetMatchingStrategy = enum {
    any_street,
    divided_street_only,

    pub const json_field_names = .{
        .any_street = "AnyStreet",
        .divided_street_only = "DividedStreetOnly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .any_street => "AnyStreet",
            .divided_street_only => "DividedStreetOnly",
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
