const std = @import("std");

pub const RoutingMode = enum {
    base_path_mapping_only,
    routing_rule_only,
    routing_rule_then_base_path_mapping,

    pub const json_field_names = .{
        .base_path_mapping_only = "BASE_PATH_MAPPING_ONLY",
        .routing_rule_only = "ROUTING_RULE_ONLY",
        .routing_rule_then_base_path_mapping = "ROUTING_RULE_THEN_BASE_PATH_MAPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .base_path_mapping_only => "BASE_PATH_MAPPING_ONLY",
            .routing_rule_only => "ROUTING_RULE_ONLY",
            .routing_rule_then_base_path_mapping => "ROUTING_RULE_THEN_BASE_PATH_MAPPING",
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
