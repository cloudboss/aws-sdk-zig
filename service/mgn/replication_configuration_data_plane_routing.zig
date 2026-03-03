const std = @import("std");

pub const ReplicationConfigurationDataPlaneRouting = enum {
    private_ip,
    public_ip,

    pub const json_field_names = .{
        .private_ip = "PRIVATE_IP",
        .public_ip = "PUBLIC_IP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .private_ip => "PRIVATE_IP",
            .public_ip => "PUBLIC_IP",
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
