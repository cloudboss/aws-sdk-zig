const std = @import("std");

/// The visibility of an app. Valid values are:
///
/// * `PRIVATE` – The app is reachable only by authorized Amazon QuickSight
///   principals.
///
/// * `PUBLIC` – The published app is reachable by anyone on the internet
///   without signing in.
pub const AppVisibility = enum {
    private,
    public,

    pub const json_field_names = .{
        .private = "PRIVATE",
        .public = "PUBLIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .private => "PRIVATE",
            .public => "PUBLIC",
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
