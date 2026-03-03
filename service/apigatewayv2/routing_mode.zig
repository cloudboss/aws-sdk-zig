const std = @import("std");

pub const RoutingMode = enum {
    api_mapping_only,
    routing_rule_only,
    routing_rule_then_api_mapping,

    pub const json_field_names = .{
        .api_mapping_only = "API_MAPPING_ONLY",
        .routing_rule_only = "ROUTING_RULE_ONLY",
        .routing_rule_then_api_mapping = "ROUTING_RULE_THEN_API_MAPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_mapping_only => "API_MAPPING_ONLY",
            .routing_rule_only => "ROUTING_RULE_ONLY",
            .routing_rule_then_api_mapping => "ROUTING_RULE_THEN_API_MAPPING",
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
