const std = @import("std");

/// The inheritance behavior for a scan-type configuration. Used with
/// `UpdateConfigurationInheritance` to reset a member account's configuration
/// to
/// inherit from the delegated administrator. The only valid value is
/// `INHERIT_FROM_ADMIN`, which resets the member account's configuration so
/// that it
/// inherits scan settings from the delegated administrator.
pub const InheritanceMode = enum {
    inherit_from_admin,

    pub const json_field_names = .{
        .inherit_from_admin = "INHERIT_FROM_ADMIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inherit_from_admin => "INHERIT_FROM_ADMIN",
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
