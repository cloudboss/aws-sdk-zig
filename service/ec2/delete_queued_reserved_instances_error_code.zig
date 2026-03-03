const std = @import("std");

pub const DeleteQueuedReservedInstancesErrorCode = enum {
    reserved_instances_id_invalid,
    reserved_instances_not_in_queued_state,
    unexpected_error,

    pub const json_field_names = .{
        .reserved_instances_id_invalid = "reserved-instances-id-invalid",
        .reserved_instances_not_in_queued_state = "reserved-instances-not-in-queued-state",
        .unexpected_error = "unexpected-error",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reserved_instances_id_invalid => "reserved-instances-id-invalid",
            .reserved_instances_not_in_queued_state => "reserved-instances-not-in-queued-state",
            .unexpected_error => "unexpected-error",
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
