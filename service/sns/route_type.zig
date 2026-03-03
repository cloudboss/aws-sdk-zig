const std = @import("std");

/// Enum listing out all supported route types. The following enum values are
/// supported.
/// 1. Transactional : Non-marketing traffic
/// 2. Promotional : Marketing
/// 3. Premium : Premium routes for OTP delivery to the carriers
pub const RouteType = enum {
    transactional,
    promotional,
    premium,

    pub const json_field_names = .{
        .transactional = "Transactional",
        .promotional = "Promotional",
        .premium = "Premium",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transactional => "Transactional",
            .promotional => "Promotional",
            .premium => "Premium",
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
