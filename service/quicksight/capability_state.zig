const std = @import("std");

/// The permission state of a capability in a custom permissions profile. Valid
/// values:
///
/// * `DENY` – Amazon Quick denies this capability for users assigned to the
///   profile.
///
/// * `ALLOW` – Amazon Quick grants this capability to users assigned to the
///   profile. This value is only relevant when governance is enabled for the
///   capability's category. Without governance, the default effect is always
///   `ALLOW`. In a governed category, this value overrides the category-level
///   deny-by-default behavior for that capability only.
pub const CapabilityState = enum {
    deny,
    allow,

    pub const json_field_names = .{
        .deny = "DENY",
        .allow = "ALLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deny => "DENY",
            .allow => "ALLOW",
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
