const std = @import("std");

pub const InputFormat = enum {
    dynamodb_json,
    ion,
    csv,

    pub const json_field_names = .{
        .dynamodb_json = "DYNAMODB_JSON",
        .ion = "ION",
        .csv = "CSV",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dynamodb_json => "DYNAMODB_JSON",
            .ion => "ION",
            .csv => "CSV",
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
