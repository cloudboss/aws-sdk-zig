const std = @import("std");

/// The type of data identifier that detected a specific type of sensitive data
/// in an S3 bucket. Possible values are:
pub const DataIdentifierType = enum {
    custom,
    managed,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .managed = "MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "CUSTOM",
            .managed => "MANAGED",
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
