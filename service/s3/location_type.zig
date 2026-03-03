const std = @import("std");

pub const LocationType = enum {
    availability_zone,
    local_zone,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .local_zone = "LocalZone",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .availability_zone => "AvailabilityZone",
            .local_zone => "LocalZone",
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
