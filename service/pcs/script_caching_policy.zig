const std = @import("std");

/// The caching policy for a node lifecycle script. Valid values:
///
/// * `CACHE_ONCE` – Downloads the script once and reuses it on subsequent
///   boots.
/// * `REFRESH_ON_REBOOT` – Downloads the script on every boot.
pub const ScriptCachingPolicy = enum {
    cache_once,
    refresh_on_reboot,

    pub const json_field_names = .{
        .cache_once = "CACHE_ONCE",
        .refresh_on_reboot = "REFRESH_ON_REBOOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cache_once => "CACHE_ONCE",
            .refresh_on_reboot => "REFRESH_ON_REBOOT",
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
