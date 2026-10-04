const std = @import("std");

pub const FulfillmentState = enum {
    fulfilled,
    failed,
    ready_for_fulfillment,

    pub const json_field_names = .{
        .fulfilled = "Fulfilled",
        .failed = "Failed",
        .ready_for_fulfillment = "ReadyForFulfillment",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fulfilled => "Fulfilled",
            .failed => "Failed",
            .ready_for_fulfillment => "ReadyForFulfillment",
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
