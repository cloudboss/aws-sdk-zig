const std = @import("std");

pub const QuoteSpecificationType = enum {
    updated_rack,
    new_rack,
    existing_rack,
    server,

    pub const json_field_names = .{
        .updated_rack = "UPDATED_RACK",
        .new_rack = "NEW_RACK",
        .existing_rack = "EXISTING_RACK",
        .server = "SERVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .updated_rack => "UPDATED_RACK",
            .new_rack => "NEW_RACK",
            .existing_rack => "EXISTING_RACK",
            .server => "SERVER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
