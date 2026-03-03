const std = @import("std");

pub const SnapshotAttributeToSortBy = enum {
    source_type,
    total_size,
    create_time,

    pub const json_field_names = .{
        .source_type = "SOURCE_TYPE",
        .total_size = "TOTAL_SIZE",
        .create_time = "CREATE_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_type => "SOURCE_TYPE",
            .total_size => "TOTAL_SIZE",
            .create_time => "CREATE_TIME",
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
