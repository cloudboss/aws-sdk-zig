const std = @import("std");

pub const RemediationType = enum {
    auto_remediation,
    console,
    cli,
    sdk,
    iac,
    mcp,

    pub const json_field_names = .{
        .auto_remediation = "AUTO_REMEDIATION",
        .console = "CONSOLE",
        .cli = "CLI",
        .sdk = "SDK",
        .iac = "IAC",
        .mcp = "MCP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_remediation => "AUTO_REMEDIATION",
            .console => "CONSOLE",
            .cli => "CLI",
            .sdk => "SDK",
            .iac => "IAC",
            .mcp => "MCP",
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
