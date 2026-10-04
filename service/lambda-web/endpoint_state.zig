const std = @import("std");

/// The state of a web function endpoint. Possible values: `Pending` (endpoint
/// is being created), `Active` (endpoint is ready to receive traffic), `Failed`
/// (endpoint creation or update failed), `Deleting` (endpoint is being
/// deleted).
pub const EndpointState = enum {
    pending,
    active,
    failed,
    deleting,

    pub const json_field_names = .{
        .pending = "Pending",
        .active = "Active",
        .failed = "Failed",
        .deleting = "Deleting",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .active => "Active",
            .failed => "Failed",
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
