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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
