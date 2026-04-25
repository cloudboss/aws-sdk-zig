/// Describes the resources available for a container instance.
pub const Resource = struct {
    /// When the `doubleValue` type is set, the value of the resource must be a
    /// double precision floating-point type.
    double_value: f64 = 0,

    /// When the `integerValue` type is set, the value of the resource must be an
    /// integer.
    integer_value: i32 = 0,

    /// When the `longValue` type is set, the value of the resource must be an
    /// extended precision floating-point type.
    long_value: i64 = 0,

    /// The name of the resource, such as `CPU`, `MEMORY`, `PORTS`, `PORTS_UDP`, or
    /// a user-defined resource.
    name: ?[]const u8 = null,

    /// When the `stringSetValue` type is set, the value of the resource must be a
    /// string type.
    string_set_value: ?[]const []const u8 = null,

    /// The type of the resource. Valid values: `INTEGER`, `DOUBLE`, `LONG`, or
    /// `STRINGSET`.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .double_value = "doubleValue",
        .integer_value = "integerValue",
        .long_value = "longValue",
        .name = "name",
        .string_set_value = "stringSetValue",
        .@"type" = "type",
    };
};
