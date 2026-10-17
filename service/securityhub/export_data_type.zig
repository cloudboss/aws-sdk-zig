const std = @import("std");

/// The category of data that an export job produces. Currently, the only
/// supported value is `FINDINGS`.
pub const ExportDataType = enum {
    findings,

    pub const json_field_names = .{
        .findings = "FINDINGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .findings => "FINDINGS",
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
