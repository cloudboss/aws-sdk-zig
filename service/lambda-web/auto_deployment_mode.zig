const std = @import("std");

/// The auto-deployment mode for a web function endpoint. Possible values:
/// `LatestRevision` (endpoint automatically serves the newest revision),
/// `Disabled` (revision routing is fixed until explicitly changed).
pub const AutoDeploymentMode = enum {
    latest_revision,
    disabled,

    pub const json_field_names = .{
        .latest_revision = "LatestRevision",
        .disabled = "Disabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .latest_revision => "LatestRevision",
            .disabled => "Disabled",
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
