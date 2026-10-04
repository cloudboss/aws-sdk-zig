const std = @import("std");

/// The filter name for filtering country launch statuses. The available filter
/// names are:
///
/// * `country-launch-status`: Filter by country launch status.
pub const CountryLaunchStatusFilterName = enum {
    country_launch_status,

    pub const json_field_names = .{
        .country_launch_status = "country-launch-status",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .country_launch_status => "country-launch-status",
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
