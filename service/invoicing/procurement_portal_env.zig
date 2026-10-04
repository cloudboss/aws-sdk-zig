const std = @import("std");

/// The environment of a procurement portal supplier. `PROD` indicates the
/// production environment. `TEST` indicates the sandbox or test environment.
pub const ProcurementPortalEnv = enum {
    /// The production environment.
    prod,
    /// The sandbox or test environment.
    @"test",

    pub const json_field_names = .{
        .prod = "PROD",
        .@"test" = "TEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prod => "PROD",
            .@"test" => "TEST",
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
