const std = @import("std");

pub const ServiceType = enum {
    data,
    credential_provider,
    jobs,

    pub const json_field_names = .{
        .data = "DATA",
        .credential_provider = "CREDENTIAL_PROVIDER",
        .jobs = "JOBS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data => "DATA",
            .credential_provider => "CREDENTIAL_PROVIDER",
            .jobs => "JOBS",
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
