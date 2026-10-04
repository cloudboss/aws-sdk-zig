const std = @import("std");

pub const AccessPointType = enum {
    delivery,
    emergency,
    entrance,
    loading,
    other,
    parking,
    taxi,

    pub const json_field_names = .{
        .delivery = "Delivery",
        .emergency = "Emergency",
        .entrance = "Entrance",
        .loading = "Loading",
        .other = "Other",
        .parking = "Parking",
        .taxi = "Taxi",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delivery => "Delivery",
            .emergency => "Emergency",
            .entrance => "Entrance",
            .loading => "Loading",
            .other => "Other",
            .parking => "Parking",
            .taxi => "Taxi",
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
