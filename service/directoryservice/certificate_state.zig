const std = @import("std");

pub const CertificateState = enum {
    registering,
    registered,
    register_failed,
    deregistering,
    deregistered,
    deregister_failed,

    pub const json_field_names = .{
        .registering = "Registering",
        .registered = "Registered",
        .register_failed = "RegisterFailed",
        .deregistering = "Deregistering",
        .deregistered = "Deregistered",
        .deregister_failed = "DeregisterFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registering => "Registering",
            .registered => "Registered",
            .register_failed => "RegisterFailed",
            .deregistering => "Deregistering",
            .deregistered => "Deregistered",
            .deregister_failed => "DeregisterFailed",
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
