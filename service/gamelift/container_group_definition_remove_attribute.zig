const std = @import("std");

pub const ContainerGroupDefinitionRemoveAttribute = enum {
    total_vcpu_limit,

    pub const json_field_names = .{
        .total_vcpu_limit = "TOTAL_VCPU_LIMIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .total_vcpu_limit => "TOTAL_VCPU_LIMIT",
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
