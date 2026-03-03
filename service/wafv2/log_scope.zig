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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
