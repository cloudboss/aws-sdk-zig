const std = @import("std");

pub const HybridUpdateType = enum {
    self_managed_instances,
    hybrid_administrator_account,

    pub const json_field_names = .{
        .self_managed_instances = "SelfManagedInstances",
        .hybrid_administrator_account = "HybridAdministratorAccount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .self_managed_instances => "SelfManagedInstances",
            .hybrid_administrator_account => "HybridAdministratorAccount",
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
