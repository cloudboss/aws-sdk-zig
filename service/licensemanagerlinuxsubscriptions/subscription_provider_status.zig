const std = @import("std");

pub const SubscriptionProviderStatus = enum {
    /// ACTIVE status
    active,
    /// INVALID status
    invalid,
    /// PENDING status
    pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .invalid = "INVALID",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .invalid => "INVALID",
            .pending => "PENDING",
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
