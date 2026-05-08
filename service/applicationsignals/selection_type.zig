const std = @import("std");

/// The strategy for selecting operations to include in a service-level SLO.
///
/// * `EXPLICIT` — You provide a specific list of operations in the `Components`
///   field of `CompositeSliConfig`.
/// * `PREFIX` — You provide a prefix string in the `Pattern` field of
///   `SelectionConfig`, and all operations whose names start with the prefix
///   are included.
/// * `REGEX` — You provide a regular expression in the `Pattern` field of
///   `SelectionConfig`, and all operations whose names match the pattern are
///   included.
pub const SelectionType = enum {
    explicit,
    prefix,
    regex,

    pub const json_field_names = .{
        .explicit = "EXPLICIT",
        .prefix = "PREFIX",
        .regex = "REGEX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .explicit => "EXPLICIT",
            .prefix => "PREFIX",
            .regex => "REGEX",
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
