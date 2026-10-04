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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
