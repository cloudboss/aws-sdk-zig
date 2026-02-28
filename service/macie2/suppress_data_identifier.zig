const DataIdentifierType = @import("data_identifier_type.zig").DataIdentifierType;

/// Specifies a custom data identifier or managed data identifier that detected
/// a type of sensitive data to exclude from an S3 bucket's sensitivity score.
pub const SuppressDataIdentifier = struct {
    /// The unique identifier for the custom data identifier or managed data
    /// identifier that detected the type of sensitive data to exclude from the
    /// score.
    id: ?[]const u8,

    /// The type of data identifier that detected the sensitive data. Possible
    /// values are: CUSTOM, for a custom data identifier; and, MANAGED, for a
    /// managed data identifier.
    @"type": ?DataIdentifierType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};
