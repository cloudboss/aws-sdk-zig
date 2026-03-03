const std = @import("std");

pub const NamespaceStatus = enum {
    created,
    creating,
    deleting,
    retryable_failure,
    non_retryable_failure,

    pub const json_field_names = .{
        .created = "CREATED",
        .creating = "CREATING",
        .deleting = "DELETING",
        .retryable_failure = "RETRYABLE_FAILURE",
        .non_retryable_failure = "NON_RETRYABLE_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .creating => "CREATING",
            .deleting => "DELETING",
            .retryable_failure => "RETRYABLE_FAILURE",
            .non_retryable_failure => "NON_RETRYABLE_FAILURE",
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
