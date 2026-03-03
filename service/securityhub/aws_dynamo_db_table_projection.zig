/// For global and local secondary indexes, identifies the attributes that are
/// copied from
/// the table into the index.
pub const AwsDynamoDbTableProjection = struct {
    /// The nonkey attributes that are projected into the index. For each attribute,
    /// provide the
    /// attribute name.
    non_key_attributes: ?[]const []const u8 = null,

    /// The types of attributes that are projected into the index. Valid values are
    /// as follows:
    ///
    /// * `ALL`
    ///
    /// * `INCLUDE`
    ///
    /// * `KEYS_ONLY`
    projection_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .non_key_attributes = "NonKeyAttributes",
        .projection_type = "ProjectionType",
    };
};
