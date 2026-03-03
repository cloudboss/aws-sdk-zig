const std = @import("std");

pub const ArtifactType = enum {
    udf,
    dependency_jar,

    pub const json_field_names = .{
        .udf = "UDF",
        .dependency_jar = "DEPENDENCY_JAR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .udf => "UDF",
            .dependency_jar => "DEPENDENCY_JAR",
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
