const std = @import("std");

/// Specifies the visibility of the project's builds. Possible values are:
///
/// **PUBLIC_READ**
///
/// The project builds are visible to the public.
///
/// **PRIVATE**
///
/// The project builds are not visible to the public.
pub const ProjectVisibilityType = enum {
    public_read,
    private,

    pub const json_field_names = .{
        .public_read = "PUBLIC_READ",
        .private = "PRIVATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_read => "PUBLIC_READ",
            .private => "PRIVATE",
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
