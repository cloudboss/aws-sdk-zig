const std = @import("std");

pub const ActionCategory = enum {
    disaster_recovery,
    operating_system,
    license_and_subscription,
    validation,
    observability,
    refactoring,
    security,
    networking,
    configuration,
    backup,
    other,

    pub const json_field_names = .{
        .disaster_recovery = "DISASTER_RECOVERY",
        .operating_system = "OPERATING_SYSTEM",
        .license_and_subscription = "LICENSE_AND_SUBSCRIPTION",
        .validation = "VALIDATION",
        .observability = "OBSERVABILITY",
        .refactoring = "REFACTORING",
        .security = "SECURITY",
        .networking = "NETWORKING",
        .configuration = "CONFIGURATION",
        .backup = "BACKUP",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disaster_recovery => "DISASTER_RECOVERY",
            .operating_system => "OPERATING_SYSTEM",
            .license_and_subscription => "LICENSE_AND_SUBSCRIPTION",
            .validation => "VALIDATION",
            .observability => "OBSERVABILITY",
            .refactoring => "REFACTORING",
            .security => "SECURITY",
            .networking => "NETWORKING",
            .configuration => "CONFIGURATION",
            .backup => "BACKUP",
            .other => "OTHER",
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
