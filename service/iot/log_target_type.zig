const std = @import("std");

pub const LogTargetType = enum {
    default,
    thing_group,
    client_id,
    source_ip,
    principal_id,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .thing_group = "THING_GROUP",
        .client_id = "CLIENT_ID",
        .source_ip = "SOURCE_IP",
        .principal_id = "PRINCIPAL_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .thing_group => "THING_GROUP",
            .client_id => "CLIENT_ID",
            .source_ip => "SOURCE_IP",
            .principal_id => "PRINCIPAL_ID",
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
