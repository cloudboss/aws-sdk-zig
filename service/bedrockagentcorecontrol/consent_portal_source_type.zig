const std = @import("std");

/// The type of a consent portal source. Currently, we only support type
/// `agentcore-gateway`.
pub const ConsentPortalSourceType = enum {
    agentcore_gateway,

    pub const json_field_names = .{
        .agentcore_gateway = "agentcore-gateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agentcore_gateway => "agentcore-gateway",
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
