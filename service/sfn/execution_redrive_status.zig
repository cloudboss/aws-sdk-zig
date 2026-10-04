const std = @import("std");

pub const ExecutionRedriveStatus = enum {
    redrivable,
    not_redrivable,
    redrivable_by_map_run,

    pub const json_field_names = .{
        .redrivable = "REDRIVABLE",
        .not_redrivable = "NOT_REDRIVABLE",
        .redrivable_by_map_run = "REDRIVABLE_BY_MAP_RUN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redrivable => "REDRIVABLE",
            .not_redrivable => "NOT_REDRIVABLE",
            .redrivable_by_map_run => "REDRIVABLE_BY_MAP_RUN",
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
