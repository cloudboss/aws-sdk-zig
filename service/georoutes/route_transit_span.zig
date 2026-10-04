const LocalizedString = @import("localized_string.zig").LocalizedString;

/// Span computed for the requested SpanAdditionalFeatures.
pub const RouteTransitSpan = struct {
    /// 3 letter Country code corresponding to the Span.
    country: ?[]const u8 = null,

    /// Distance of the computed span. This feature doesn't split a span, but is
    /// always computed on a span split by other properties.
    ///
    /// **Unit**: `meters`
    distance: ?i64 = null,

    /// Duration of the computed span. This feature doesn't split a span, but is
    /// always computed on a span split by other properties.
    ///
    /// **Unit**: `seconds`
    duration: ?i64 = null,

    /// Offset in the leg geometry corresponding to the start of this span.
    geometry_offset: ?i32 = null,

    /// Names of the transit span in available languages.
    names: ?[]const LocalizedString = null,

    /// 2-3 letter Region code corresponding to the Span. This is either a province
    /// or a state.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .country = "Country",
        .distance = "Distance",
        .duration = "Duration",
        .geometry_offset = "GeometryOffset",
        .names = "Names",
        .region = "Region",
    };
};
