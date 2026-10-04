const std = @import("std");

pub const TaskType = enum {
    arithmetic,
    filter,
    map,
    mask,
    merge,
    truncate,
    validate,

    pub const json_field_names = .{
        .arithmetic = "Arithmetic",
        .filter = "Filter",
        .map = "Map",
        .mask = "Mask",
        .merge = "Merge",
        .truncate = "Truncate",
        .validate = "Validate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arithmetic => "Arithmetic",
            .filter => "Filter",
            .map => "Map",
            .mask => "Mask",
            .merge => "Merge",
            .truncate => "Truncate",
            .validate => "Validate",
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
