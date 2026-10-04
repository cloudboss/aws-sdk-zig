const std = @import("std");

pub const DataShareStatusForProducer = enum {
    active,
    authorized,
    pending_authorization,
    deauthorized,
    rejected,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .authorized = "AUTHORIZED",
        .pending_authorization = "PENDING_AUTHORIZATION",
        .deauthorized = "DEAUTHORIZED",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .authorized => "AUTHORIZED",
            .pending_authorization => "PENDING_AUTHORIZATION",
            .deauthorized => "DEAUTHORIZED",
            .rejected => "REJECTED",
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
