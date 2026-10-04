const std = @import("std");

/// The lifecycle status of a managed MicroVM image version.
pub const ManagedMicrovmImageVersionStatus = enum {
    /// The version is available for use.
    available,
    /// The version is deprecated. Do not use this version for new MicroVM images.
    /// Existing MicroVM images that use this version will continue to function.
    deprecated,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .deprecated = "DEPRECATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .deprecated => "DEPRECATED",
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
