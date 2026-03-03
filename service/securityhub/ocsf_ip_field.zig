const std = @import("std");

pub const OcsfIpField = enum {
    evidences_dst_endpoint_ip,
    evidences_src_endpoint_ip,

    pub const json_field_names = .{
        .evidences_dst_endpoint_ip = "evidences.dst_endpoint.ip",
        .evidences_src_endpoint_ip = "evidences.src_endpoint.ip",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .evidences_dst_endpoint_ip => "evidences.dst_endpoint.ip",
            .evidences_src_endpoint_ip => "evidences.src_endpoint.ip",
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
