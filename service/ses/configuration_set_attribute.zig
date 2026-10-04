const std = @import("std");

pub const ConfigurationSetAttribute = enum {
    event_destinations,
    tracking_options,
    delivery_options,
    reputation_options,

    pub const json_field_names = .{
        .event_destinations = "eventDestinations",
        .tracking_options = "trackingOptions",
        .delivery_options = "deliveryOptions",
        .reputation_options = "reputationOptions",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_destinations => "eventDestinations",
            .tracking_options => "trackingOptions",
            .delivery_options => "deliveryOptions",
            .reputation_options => "reputationOptions",
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
