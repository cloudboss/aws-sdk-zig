const std = @import("std");

pub const RedshiftQueryEngineStorageType = enum {
    redshift,
    aws_data_catalog,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .aws_data_catalog = "AWS_DATA_CATALOG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redshift => "REDSHIFT",
            .aws_data_catalog => "AWS_DATA_CATALOG",
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
