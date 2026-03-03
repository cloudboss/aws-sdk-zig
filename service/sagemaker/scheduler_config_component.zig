const std = @import("std");

pub const SchedulerConfigComponent = enum {
    priority_classes,
    fair_share,
    idle_resource_sharing,

    pub const json_field_names = .{
        .priority_classes = "PriorityClasses",
        .fair_share = "FairShare",
        .idle_resource_sharing = "IdleResourceSharing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .priority_classes => "PriorityClasses",
            .fair_share => "FairShare",
            .idle_resource_sharing => "IdleResourceSharing",
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
