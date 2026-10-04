const std = @import("std");

pub const ActionType = enum {
    rightsize,
    stop,
    upgrade,
    purchase_savings_plans,
    purchase_reserved_instances,
    migrate_to_graviton,
    delete,
    scale_in,

    pub const json_field_names = .{
        .rightsize = "Rightsize",
        .stop = "Stop",
        .upgrade = "Upgrade",
        .purchase_savings_plans = "PurchaseSavingsPlans",
        .purchase_reserved_instances = "PurchaseReservedInstances",
        .migrate_to_graviton = "MigrateToGraviton",
        .delete = "Delete",
        .scale_in = "ScaleIn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rightsize => "Rightsize",
            .stop => "Stop",
            .upgrade => "Upgrade",
            .purchase_savings_plans => "PurchaseSavingsPlans",
            .purchase_reserved_instances => "PurchaseReservedInstances",
            .migrate_to_graviton => "MigrateToGraviton",
            .delete => "Delete",
            .scale_in => "ScaleIn",
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
