const std = @import("std");

pub const TrafficMirrorFilterRuleField = enum {
    destination_port_range,
    source_port_range,
    protocol,
    description,

    pub const json_field_names = .{
        .destination_port_range = "destination-port-range",
        .source_port_range = "source-port-range",
        .protocol = "protocol",
        .description = "description",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .destination_port_range => "destination-port-range",
            .source_port_range => "source-port-range",
            .protocol => "protocol",
            .description => "description",
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
