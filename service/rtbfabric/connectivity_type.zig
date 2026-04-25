const std = @import("std");

/// The connectivity type for a link or gateway.
pub const ConnectivityType = enum {
    default,
    public_ingress,
    public_egress,
    external_inbound,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .public_ingress = "PUBLIC_INGRESS",
        .public_egress = "PUBLIC_EGRESS",
        .external_inbound = "EXTERNAL_INBOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .public_ingress => "PUBLIC_INGRESS",
            .public_egress => "PUBLIC_EGRESS",
            .external_inbound => "EXTERNAL_INBOUND",
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
