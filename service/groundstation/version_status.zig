const std = @import("std");

pub const VersionStatus = enum {
    /// The version is being applied to the contact.
    updating,
    /// The version is the current active version of the contact.
    active,
    /// The version has been replaced by a newer version.
    superseded,
    /// The version update failed.
    failed_to_update,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .active = "ACTIVE",
        .superseded = "SUPERSEDED",
        .failed_to_update = "FAILED_TO_UPDATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .updating => "UPDATING",
            .active => "ACTIVE",
            .superseded => "SUPERSEDED",
            .failed_to_update => "FAILED_TO_UPDATE",
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
