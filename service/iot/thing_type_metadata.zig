/// The ThingTypeMetadata contains additional information about the thing type
/// including: creation date and
/// time, a value indicating whether the thing type is deprecated, and a date
/// and time when time was
/// deprecated.
pub const ThingTypeMetadata = struct {
    /// The date and time when the thing type was created.
    creation_date: ?i64 = null,

    /// Whether the thing type is deprecated. If **true**, no new things could be
    /// associated with this type.
    deprecated: bool = false,

    /// The date and time when the thing type was deprecated.
    deprecation_date: ?i64 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .deprecated = "deprecated",
        .deprecation_date = "deprecationDate",
    };
};
