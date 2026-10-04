const std = @import("std");

pub const FindingType = enum {
    network_reachability,
    package_vulnerability,
    code_vulnerability,

    pub const json_field_names = .{
        .network_reachability = "NETWORK_REACHABILITY",
        .package_vulnerability = "PACKAGE_VULNERABILITY",
        .code_vulnerability = "CODE_VULNERABILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .network_reachability => "NETWORK_REACHABILITY",
            .package_vulnerability => "PACKAGE_VULNERABILITY",
            .code_vulnerability => "CODE_VULNERABILITY",
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
