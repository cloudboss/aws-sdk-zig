const std = @import("std");

/// The package manager for a notebook run environment in Amazon DataZone.
pub const PackageManager = enum {
    /// The UV package manager.
    uv,

    pub const json_field_names = .{
        .uv = "UV",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .uv => "UV",
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
