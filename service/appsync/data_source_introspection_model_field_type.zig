/// Represents the type data for each field retrieved from the introspection.
pub const DataSourceIntrospectionModelFieldType = struct {
    /// Specifies the classification of data. For example, this could be set to
    /// values like
    /// `Scalar` or `NonNull` to indicate a fundamental property of the
    /// field.
    ///
    /// Valid values include:
    ///
    /// * `Scalar`: Indicates the value is a primitive type
    /// (scalar).
    ///
    /// * `NonNull`: Indicates the field cannot be
    /// `null`.
    ///
    /// * `List`: Indicates the field contains a list.
    kind: ?[]const u8,

    /// The name of the data type that represents the field. For example, `String`
    /// is
    /// a valid `name` value.
    name: ?[]const u8,

    /// The `DataSourceIntrospectionModelFieldType` object data. The
    /// `type` is only present if
    /// `DataSourceIntrospectionModelFieldType.kind` is set to `NonNull`
    /// or `List`.
    ///
    /// The `type` typically contains its own `kind` and `name`
    /// fields to represent the actual type data. For instance, `type` could contain
    /// a
    /// `kind` value of `Scalar` with a `name` value of
    /// `String`. The values `Scalar` and `String` will be
    /// collectively stored in the `values` field.
    @"type": ?*DataSourceIntrospectionModelFieldType = null,

    /// The values of the `type` field. This field represents the AppSync data type
    /// equivalent of the introspected field.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .kind = "kind",
        .name = "name",
        .@"type" = "type",
        .values = "values",
    };
};
