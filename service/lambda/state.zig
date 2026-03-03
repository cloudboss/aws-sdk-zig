const std = @import("std");

pub const State = enum {
    pending,
    active,
    inactive,
    failed,
    deactivating,
    deactivated,
    active_non_invocable,
    deleting,

    pub const json_field_names = .{
        .pending = "Pending",
        .active = "Active",
        .inactive = "Inactive",
        .failed = "Failed",
        .deactivating = "Deactivating",
        .deactivated = "Deactivated",
        .active_non_invocable = "ActiveNonInvocable",
        .deleting = "Deleting",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .active => "Active",
            .inactive => "Inactive",
            .failed => "Failed",
            .deactivating => "Deactivating",
            .deactivated => "Deactivated",
            .active_non_invocable => "ActiveNonInvocable",
            .deleting => "Deleting",
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
