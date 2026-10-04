const std = @import("std");

pub const ListAggregateLogGroupSummariesGroupBy = enum {
    data_source_name_type_and_format,
    data_source_name_and_type,

    pub const json_field_names = .{
        .data_source_name_type_and_format = "DATA_SOURCE_NAME_TYPE_AND_FORMAT",
        .data_source_name_and_type = "DATA_SOURCE_NAME_AND_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_source_name_type_and_format => "DATA_SOURCE_NAME_TYPE_AND_FORMAT",
            .data_source_name_and_type => "DATA_SOURCE_NAME_AND_TYPE",
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
