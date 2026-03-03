const DateArrayOptions = @import("date_array_options.zig").DateArrayOptions;
const DateOptions = @import("date_options.zig").DateOptions;
const DoubleArrayOptions = @import("double_array_options.zig").DoubleArrayOptions;
const DoubleOptions = @import("double_options.zig").DoubleOptions;
const IndexFieldType = @import("index_field_type.zig").IndexFieldType;
const IntArrayOptions = @import("int_array_options.zig").IntArrayOptions;
const IntOptions = @import("int_options.zig").IntOptions;
const LatLonOptions = @import("lat_lon_options.zig").LatLonOptions;
const LiteralArrayOptions = @import("literal_array_options.zig").LiteralArrayOptions;
const LiteralOptions = @import("literal_options.zig").LiteralOptions;
const TextArrayOptions = @import("text_array_options.zig").TextArrayOptions;
const TextOptions = @import("text_options.zig").TextOptions;

/// Configuration information for a field in the index, including its name,
/// type, and options. The supported options depend on the `IndexFieldType`.
pub const IndexField = struct {
    date_array_options: ?DateArrayOptions = null,

    date_options: ?DateOptions = null,

    double_array_options: ?DoubleArrayOptions = null,

    double_options: ?DoubleOptions = null,

    /// A string that represents the name of an index field. CloudSearch supports
    /// regular index fields as well as dynamic fields.
    /// A dynamic field's name defines a pattern that begins or ends with a
    /// wildcard.
    /// Any document fields that don't map to a regular index field but do match a
    /// dynamic field's pattern are configured with the dynamic field's indexing
    /// options.
    ///
    /// Regular field names begin with a letter and can contain the following
    /// characters:
    /// a-z (lowercase), 0-9, and _ (underscore).
    /// Dynamic field names must begin or end with a wildcard (*).
    /// The wildcard can also be the only character in a dynamic field name.
    /// Multiple wildcards, and wildcards embedded within a string are not
    /// supported.
    ///
    /// The name `score` is reserved and cannot be used as a field name.
    /// To reference a document's ID, you can use the name `_id`.
    index_field_name: []const u8,

    index_field_type: IndexFieldType,

    int_array_options: ?IntArrayOptions = null,

    int_options: ?IntOptions = null,

    lat_lon_options: ?LatLonOptions = null,

    literal_array_options: ?LiteralArrayOptions = null,

    literal_options: ?LiteralOptions = null,

    text_array_options: ?TextArrayOptions = null,

    text_options: ?TextOptions = null,
};
