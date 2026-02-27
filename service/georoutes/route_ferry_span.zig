const LocalizedString = @import("localized_string.zig").LocalizedString;

/// Span computed for the requested SpanAdditionalFeatures.
pub const RouteFerrySpan = struct {
    /// 3 letter Country code corresponding to the Span.
    country: ?[]const u8,

    /// Distance of the computed span. This feature doesn't split a span, but is
    /// always computed on a span split by other properties.
    ///
    /// **Unit**: `meters`
    distance: i64 = 0,

    /// Duration of the computed span. This feature doesn't split a span, but is
    /// always computed on a span split by other properties.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Offset in the leg geometry corresponding to the start of this span.
    geometry_offset: ?i32,

    /// Provides an array of names of the ferry span in available languages.
    names: ?[]const LocalizedString,

    /// 2-3 letter Region code corresponding to the Span. This is either a province
    /// or a state.
    region: ?[]const u8,

    pub const json_field_names = .{
        .country = "Country",
        .distance = "Distance",
        .duration = "Duration",
        .geometry_offset = "GeometryOffset",
        .names = "Names",
        .region = "Region",
    };
};
