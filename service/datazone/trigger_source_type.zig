const std = @import("std");

/// The type of trigger source for a notebook run in Amazon DataZone.
pub const TriggerSourceType = enum {
    /// The notebook run was triggered manually.
    manual,
    /// The notebook run was triggered by a schedule.
    scheduled,
    /// The notebook run was triggered by a workflow.
    workflow,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .scheduled = "SCHEDULED",
        .workflow = "WORKFLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manual => "MANUAL",
            .scheduled => "SCHEDULED",
            .workflow => "WORKFLOW",
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
