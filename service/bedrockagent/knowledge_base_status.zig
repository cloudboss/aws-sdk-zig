const std = @import("std");

pub const KnowledgeBaseStatus = enum {
    creating,
    active,
    deleting,
    updating,
    failed,
    delete_unsuccessful,
    update_unsuccessful,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .delete_unsuccessful = "DELETE_UNSUCCESSFUL",
        .update_unsuccessful = "UPDATE_UNSUCCESSFUL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .updating => "UPDATING",
            .failed => "FAILED",
            .delete_unsuccessful => "DELETE_UNSUCCESSFUL",
            .update_unsuccessful => "UPDATE_UNSUCCESSFUL",
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
