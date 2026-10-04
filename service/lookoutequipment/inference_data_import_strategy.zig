const std = @import("std");

pub const InferenceDataImportStrategy = enum {
    no_import,
    add_when_empty,
    overwrite,

    pub const json_field_names = .{
        .no_import = "NO_IMPORT",
        .add_when_empty = "ADD_WHEN_EMPTY",
        .overwrite = "OVERWRITE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_import => "NO_IMPORT",
            .add_when_empty => "ADD_WHEN_EMPTY",
            .overwrite => "OVERWRITE",
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
