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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
