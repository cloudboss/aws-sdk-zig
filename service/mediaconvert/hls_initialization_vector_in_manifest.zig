const std = @import("std");

/// The Initialization Vector is a 128-bit number used in conjunction with the
/// key for encrypting blocks. If set to INCLUDE, Initialization Vector is
/// listed in the manifest. Otherwise Initialization Vector is not in the
/// manifest.
pub const HlsInitializationVectorInManifest = enum {
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
