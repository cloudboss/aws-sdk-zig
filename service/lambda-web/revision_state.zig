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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
