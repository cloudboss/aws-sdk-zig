const std = @import("std");

/// The name of the cloud provider for a CSPM connector.
pub const CspmConnectorProviderName = enum {
    azure,

    pub const json_field_names = .{
        .azure = "AZURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .azure => "AZURE",
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
