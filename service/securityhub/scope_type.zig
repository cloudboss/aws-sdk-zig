const std = @import("std");

/// The type of scope for an Azure connector. Valid values are `TENANT` (monitor
/// all subscriptions in the tenant) and `SUBSCRIPTION` (monitor specific
/// subscriptions).
pub const ScopeType = enum {
    tenant,
    subscription,

    pub const json_field_names = .{
        .tenant = "TENANT",
        .subscription = "SUBSCRIPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tenant => "TENANT",
            .subscription => "SUBSCRIPTION",
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
