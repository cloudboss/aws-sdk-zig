const std = @import("std");

pub const LogScope = enum {
    customer,
    security_lake,
    cloudwatch_telemetry_rule_managed,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .security_lake = "SECURITY_LAKE",
        .cloudwatch_telemetry_rule_managed = "CLOUDWATCH_TELEMETRY_RULE_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer => "CUSTOMER",
            .security_lake => "SECURITY_LAKE",
            .cloudwatch_telemetry_rule_managed => "CLOUDWATCH_TELEMETRY_RULE_MANAGED",
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
