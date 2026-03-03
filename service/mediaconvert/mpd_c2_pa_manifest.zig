const std = @import("std");

/// When enabled, a C2PA compliant manifest will be generated, signed and
/// embeded in the output. For more information on C2PA, see
/// https://c2pa.org/specifications/specifications/2.1/index.html
pub const MpdC2paManifest = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .include => "INCLUDE",
            .exclude => "EXCLUDE",
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
