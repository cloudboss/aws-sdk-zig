const std = @import("std");

pub const SecurityPolicyType = enum {
    tls_v1,
    tls_v1_2_2021,
    tls_v1_3_2025,

    pub const json_field_names = .{
        .tls_v1 = "TLS_V1",
        .tls_v1_2_2021 = "TLS_V1_2_2021",
        .tls_v1_3_2025 = "TLS_V1_3_2025",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tls_v1 => "TLS_V1",
            .tls_v1_2_2021 => "TLS_V1_2_2021",
            .tls_v1_3_2025 => "TLS_V1_3_2025",
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
