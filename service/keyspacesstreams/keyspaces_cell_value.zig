const aws = @import("aws");

const KeyspacesCell = @import("keyspaces_cell.zig").KeyspacesCell;
const KeyspacesCellMapDefinition = @import("keyspaces_cell_map_definition.zig").KeyspacesCellMapDefinition;

/// Represents the value of a cell in an Amazon Keyspaces table, supporting
/// various data types with type-specific fields.
pub const KeyspacesCellValue = union(enum) {
    /// A value of ASCII text type, containing US-ASCII characters.
    ascii_t: ?[]const u8,
    /// A 64-bit signed integer value.
    bigint_t: ?[]const u8,
    /// A binary large object (BLOB) value stored as a Base64-encoded string.
    blob_t: ?[]const u8,
    /// A Boolean value, either `true` or `false`.
    bool_t: ?bool,
    /// A distributed counter value that can be incremented and decremented.
    counter_t: ?[]const u8,
    /// A date value without a time component, represented as days since epoch
    /// (January 1, 1970).
    date_t: ?[]const u8,
    /// A variable-precision decimal number value.
    decimal_t: ?[]const u8,
    /// A 64-bit double-precision floating point value.
    double_t: ?[]const u8,
    /// A 32-bit single-precision floating point value.
    float_t: ?[]const u8,
    /// An IP address value, either IPv4 or IPv6 format.
    inet_t: ?[]const u8,
    /// A 32-bit signed integer value.
    int_t: ?[]const u8,
    /// An ordered collection of elements that can contain duplicate values.
    list_t: ?[]const KeyspacesCell,
    /// A collection of key-value pairs where each key is unique.
    map_t: ?[]const KeyspacesCellMapDefinition,
    /// An unordered collection of unique elements.
    set_t: ?[]const KeyspacesCell,
    /// A 16-bit signed integer value.
    smallint_t: ?[]const u8,
    /// A UTF-8 encoded string value.
    text_t: ?[]const u8,
    /// A timestamp value representing date and time with millisecond precision.
    timestamp_t: ?[]const u8,
    /// A time value without a date component, with nanosecond precision.
    time_t: ?[]const u8,
    /// A universally unique identifier (UUID) that includes a timestamp component,
    /// ensuring both uniqueness and time ordering.
    timeuuid_t: ?[]const u8,
    /// An 8-bit signed integer value.
    tinyint_t: ?[]const u8,
    /// A fixed-length ordered list of elements, where each element can be of a
    /// different data type.
    tuple_t: ?[]const KeyspacesCell,
    /// A user-defined type (UDT) value consisting of named fields, each with its
    /// own data type.
    udt_t: ?[]const aws.map.MapEntry(KeyspacesCell),
    /// A universally unique identifier (UUID) value.
    uuid_t: ?[]const u8,
    /// A UTF-8 encoded string value, functionally equivalent to text type.
    varchar_t: ?[]const u8,
    /// A variable precision integer value with arbitrary length.
    varint_t: ?[]const u8,

    pub const json_field_names = .{
        .ascii_t = "asciiT",
        .bigint_t = "bigintT",
        .blob_t = "blobT",
        .bool_t = "boolT",
        .counter_t = "counterT",
        .date_t = "dateT",
        .decimal_t = "decimalT",
        .double_t = "doubleT",
        .float_t = "floatT",
        .inet_t = "inetT",
        .int_t = "intT",
        .list_t = "listT",
        .map_t = "mapT",
        .set_t = "setT",
        .smallint_t = "smallintT",
        .text_t = "textT",
        .timestamp_t = "timestampT",
        .time_t = "timeT",
        .timeuuid_t = "timeuuidT",
        .tinyint_t = "tinyintT",
        .tuple_t = "tupleT",
        .udt_t = "udtT",
        .uuid_t = "uuidT",
        .varchar_t = "varcharT",
        .varint_t = "varintT",
    };
};
