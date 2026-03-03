const std = @import("std");

pub const PartnerIntegrationStatus = enum {
    active,
    inactive,
    runtime_failure,
    connection_failure,

    pub const json_field_names = .{
        .active = "Active",
        .inactive = "Inactive",
        .runtime_failure = "RuntimeFailure",
        .connection_failure = "ConnectionFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "Active",
            .inactive => "Inactive",
            .runtime_failure => "RuntimeFailure",
            .connection_failure => "ConnectionFailure",
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
