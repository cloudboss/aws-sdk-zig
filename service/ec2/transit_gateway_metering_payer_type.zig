const std = @import("std");

pub const TransitGatewayMeteringPayerType = enum {
    source_attachment_owner,
    destination_attachment_owner,
    transit_gateway_owner,

    pub const json_field_names = .{
        .source_attachment_owner = "source-attachment-owner",
        .destination_attachment_owner = "destination-attachment-owner",
        .transit_gateway_owner = "transit-gateway-owner",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_attachment_owner => "source-attachment-owner",
            .destination_attachment_owner => "destination-attachment-owner",
            .transit_gateway_owner => "transit-gateway-owner",
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
