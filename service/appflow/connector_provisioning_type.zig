const std = @import("std");

/// The type of provisioning that the connector supports, such as Lambda.
pub const ConnectorProvisioningType = enum {
    lambda,

    pub const json_field_names = .{
        .lambda = "LAMBDA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lambda => "LAMBDA",
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
