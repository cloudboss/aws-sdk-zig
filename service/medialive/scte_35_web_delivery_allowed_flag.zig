const std = @import("std");

/// Corresponds to the web_delivery_allowed_flag parameter. A value of
/// WEB_DELIVERY_NOT_ALLOWED corresponds to 0 (false) in the SCTE-35
/// specification. If you include one of the "restriction" flags then you must
/// include all four of them.
pub const Scte35WebDeliveryAllowedFlag = enum {
    web_delivery_not_allowed,
    web_delivery_allowed,

    pub const json_field_names = .{
        .web_delivery_not_allowed = "WEB_DELIVERY_NOT_ALLOWED",
        .web_delivery_allowed = "WEB_DELIVERY_ALLOWED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .web_delivery_not_allowed => "WEB_DELIVERY_NOT_ALLOWED",
            .web_delivery_allowed => "WEB_DELIVERY_ALLOWED",
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
