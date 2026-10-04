const std = @import("std");

/// The state of a web function revision. Possible values: `Pending` (revision
/// is being built), `Active` (revision is ready to serve traffic), `Failed`
/// (revision build failed).
pub const RevisionState = enum {
    pending,
    active,
    failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .active = "Active",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .active => "Active",
            .failed => "Failed",
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
