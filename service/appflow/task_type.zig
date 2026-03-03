const std = @import("std");

pub const TaskType = enum {
    arithmetic,
    filter,
    map,
    map_all,
    mask,
    merge,
    passthrough,
    truncate,
    validate,
    partition,

    pub const json_field_names = .{
        .arithmetic = "Arithmetic",
        .filter = "Filter",
        .map = "Map",
        .map_all = "Map_all",
        .mask = "Mask",
        .merge = "Merge",
        .passthrough = "Passthrough",
        .truncate = "Truncate",
        .validate = "Validate",
        .partition = "Partition",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arithmetic => "Arithmetic",
            .filter => "Filter",
            .map => "Map",
            .map_all => "Map_all",
            .mask => "Mask",
            .merge => "Merge",
            .passthrough => "Passthrough",
            .truncate => "Truncate",
            .validate => "Validate",
            .partition => "Partition",
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
