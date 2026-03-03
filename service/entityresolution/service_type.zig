const std = @import("std");

pub const ServiceType = enum {
    assignment,
    id_mapping,

    pub const json_field_names = .{
        .assignment = "ASSIGNMENT",
        .id_mapping = "ID_MAPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assignment => "ASSIGNMENT",
            .id_mapping => "ID_MAPPING",
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
