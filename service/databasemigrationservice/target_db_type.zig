const std = @import("std");

pub const TargetDbType = enum {
    specific_database,
    multiple_databases,

    pub const json_field_names = .{
        .specific_database = "specific-database",
        .multiple_databases = "multiple-databases",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .specific_database => "specific-database",
            .multiple_databases => "multiple-databases",
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
