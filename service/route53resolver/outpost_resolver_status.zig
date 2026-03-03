const std = @import("std");

pub const OutpostResolverStatus = enum {
    creating,
    operational,
    updating,
    deleting,
    action_needed,
    failed_creation,
    failed_deletion,

    pub const json_field_names = .{
        .creating = "CREATING",
        .operational = "OPERATIONAL",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .action_needed = "ACTION_NEEDED",
        .failed_creation = "FAILED_CREATION",
        .failed_deletion = "FAILED_DELETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .operational => "OPERATIONAL",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .action_needed => "ACTION_NEEDED",
            .failed_creation => "FAILED_CREATION",
            .failed_deletion => "FAILED_DELETION",
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
