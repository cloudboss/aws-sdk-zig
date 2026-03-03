const std = @import("std");

pub const AmiSortBy = enum {
    critical,
    high,
    all,
    affected_instances,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .all = "ALL",
        .affected_instances = "AFFECTED_INSTANCES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .critical => "CRITICAL",
            .high => "HIGH",
            .all => "ALL",
            .affected_instances => "AFFECTED_INSTANCES",
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
