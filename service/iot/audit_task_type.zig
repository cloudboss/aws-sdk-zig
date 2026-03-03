const std = @import("std");

pub const AuditTaskType = enum {
    on_demand_audit_task,
    scheduled_audit_task,

    pub const json_field_names = .{
        .on_demand_audit_task = "ON_DEMAND_AUDIT_TASK",
        .scheduled_audit_task = "SCHEDULED_AUDIT_TASK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand_audit_task => "ON_DEMAND_AUDIT_TASK",
            .scheduled_audit_task => "SCHEDULED_AUDIT_TASK",
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
