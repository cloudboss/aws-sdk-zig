const std = @import("std");

/// Indicates whether a threat was created or updated by a customer or an agent.
pub const ThreatActor = enum {
    /// Threat was created or updated by a customer.
    customer,
    /// Threat was created or updated by an agent.
    agent,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .agent = "AGENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer => "CUSTOMER",
            .agent => "AGENT",
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
