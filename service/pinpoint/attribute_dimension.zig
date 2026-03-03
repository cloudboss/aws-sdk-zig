const AttributeType = @import("attribute_type.zig").AttributeType;

/// Specifies attribute-based criteria for including or excluding endpoints from
/// a segment.
pub const AttributeDimension = struct {
    /// The type of segment dimension to use. Valid values are:
    ///
    /// * INCLUSIVE - endpoints that have attributes matching the values are
    ///   included in the segment.
    /// * EXCLUSIVE - endpoints that have attributes matching the values are
    ///   excluded in the segment.
    /// * CONTAINS - endpoints that have attributes' substrings match the values are
    ///   included in the segment.
    /// * BEFORE - endpoints with attributes read as ISO_INSTANT datetimes before
    ///   the value are included in the segment.
    /// * AFTER - endpoints with attributes read as ISO_INSTANT datetimes after the
    ///   value are included in the segment.
    /// * ON - endpoints with attributes read as ISO_INSTANT dates on the value are
    ///   included in the segment. Time is ignored in this comparison.
    /// * BETWEEN - endpoints with attributes read as ISO_INSTANT datetimes between
    ///   the values are included in the segment.
    attribute_type: ?AttributeType = null,

    /// The criteria values to use for the segment dimension. Depending on the value
    /// of the AttributeType property, endpoints are included or excluded from the
    /// segment if their attribute values match the criteria values.
    values: []const []const u8,

    pub const json_field_names = .{
        .attribute_type = "AttributeType",
        .values = "Values",
    };
};
