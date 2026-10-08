const std = @import("std");

pub const SellerEngagementType = enum {
    request_for_private_offer,
    request_for_demo,

    pub const json_field_names = .{
        .request_for_private_offer = "REQUEST_FOR_PRIVATE_OFFER",
        .request_for_demo = "REQUEST_FOR_DEMO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request_for_private_offer => "REQUEST_FOR_PRIVATE_OFFER",
            .request_for_demo => "REQUEST_FOR_DEMO",
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
