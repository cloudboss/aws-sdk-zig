const TypePlacement = @import("type_placement.zig").TypePlacement;

/// Components of a street.
pub const StreetComponents = struct {
    /// Base name part of the street name.
    ///
    /// Example: Younge from the "Younge street".
    base_name: ?[]const u8 = null,

    /// Indicates the official directional identifiers assigned to highways.
    direction: ?[]const u8 = null,

    /// A [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag) compliant
    /// language codes for the results to be rendered in. If there is no data for
    /// the result in the requested language, data will be returned in the default
    /// language for the entry.
    language: ?[]const u8 = null,

    /// A prefix is a directional identifier that precedes, but is not included in,
    /// the base name of a road.
    ///
    /// Example: E for East.
    prefix: ?[]const u8 = null,

    /// A suffix is a directional identifier that follows, but is not included in,
    /// the base name of a road.
    ///
    /// Example W for West.
    suffix: ?[]const u8 = null,

    /// Street type part of the street name.
    ///
    /// Example: `"avenue"`.
    @"type": ?[]const u8 = null,

    /// Defines if the street type is before or after the base name.
    type_placement: ?TypePlacement = null,

    /// Defines a separator character such as `""` or `" "` between the base name
    /// and type.
    type_separator: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_name = "BaseName",
        .direction = "Direction",
        .language = "Language",
        .prefix = "Prefix",
        .suffix = "Suffix",
        .@"type" = "Type",
        .type_placement = "TypePlacement",
        .type_separator = "TypeSeparator",
    };
};
