const std = @import("std");

/// Optional field, defaults to DEFAULT. Specify DEFAULT for this operation to
/// return your endpoints if any exist, or to create an endpoint for you and
/// return it if one doesn't already exist. Specify GET_ONLY to return your
/// endpoints if any exist, or an empty list if none exist.
pub const DescribeEndpointsMode = enum {
    default,
    get_only,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .get_only = "GET_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .get_only => "GET_ONLY",
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
