const std = @import("std");

pub const FeatureGroupStatus = enum {
    creating,
    created,
    create_failed,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .created = "Created",
        .create_failed = "CreateFailed",
        .deleting = "Deleting",
        .delete_failed = "DeleteFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .created => "Created",
            .create_failed => "CreateFailed",
            .deleting => "Deleting",
            .delete_failed => "DeleteFailed",
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
