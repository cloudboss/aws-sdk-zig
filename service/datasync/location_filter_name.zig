const std = @import("std");

pub const LocationFilterName = enum {
    location_uri,
    location_type,
    creation_time,

    pub const json_field_names = .{
        .location_uri = "LocationUri",
        .location_type = "LocationType",
        .creation_time = "CreationTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .location_uri => "LocationUri",
            .location_type => "LocationType",
            .creation_time => "CreationTime",
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
