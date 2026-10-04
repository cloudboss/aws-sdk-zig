const std = @import("std");

/// The default effect that Amazon Quick applies to capabilities in a governed
/// category when you do not explicitly list those capabilities in
/// `Capabilities`. Valid values:
///
/// * `DENY_BY_DEFAULT` – Amazon Quick denies any capability access in the given
///   category that the profile does not explicitly set to `ALLOW`.
pub const DefaultCategoryEffect = enum {
    deny_by_default,

    pub const json_field_names = .{
        .deny_by_default = "DENY_BY_DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deny_by_default => "DENY_BY_DEFAULT",
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
