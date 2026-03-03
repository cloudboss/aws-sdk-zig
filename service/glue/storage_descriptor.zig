const aws = @import("aws");

const Column = @import("column.zig").Column;
const SchemaReference = @import("schema_reference.zig").SchemaReference;
const SerDeInfo = @import("ser_de_info.zig").SerDeInfo;
const SkewedInfo = @import("skewed_info.zig").SkewedInfo;
const Order = @import("order.zig").Order;

/// Describes the physical storage of table data.
pub const StorageDescriptor = struct {
    /// A list of locations that point to the path where a Delta table is located.
    additional_locations: ?[]const []const u8 = null,

    /// A list of reducer grouping columns, clustering columns, and
    /// bucketing columns in the table.
    bucket_columns: ?[]const []const u8 = null,

    /// A list of the `Columns` in the table.
    columns: ?[]const Column = null,

    /// `True` if the data in the table is compressed, or `False` if
    /// not.
    compressed: bool = false,

    /// The input format: `SequenceFileInputFormat` (binary),
    /// or `TextInputFormat`, or a custom format.
    input_format: ?[]const u8 = null,

    /// The physical location of the table. By default, this takes the form of the
    /// warehouse
    /// location, followed by the database location in the warehouse, followed by
    /// the table
    /// name.
    location: ?[]const u8 = null,

    /// Must be specified if the table contains any dimension columns.
    number_of_buckets: i32 = 0,

    /// The output format: `SequenceFileOutputFormat` (binary),
    /// or `IgnoreKeyTextOutputFormat`, or a custom format.
    output_format: ?[]const u8 = null,

    /// The user-supplied properties in key-value form.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// An object that references a schema stored in the Glue Schema Registry.
    ///
    /// When creating a table, you can pass an empty list of columns for the schema,
    /// and instead use a schema reference.
    schema_reference: ?SchemaReference = null,

    /// The serialization/deserialization (SerDe) information.
    serde_info: ?SerDeInfo = null,

    /// The information about values that appear frequently in a column (skewed
    /// values).
    skewed_info: ?SkewedInfo = null,

    /// A list specifying the sort order of each bucket in the table.
    sort_columns: ?[]const Order = null,

    /// `True` if the table data is stored in subdirectories, or `False` if
    /// not.
    stored_as_sub_directories: bool = false,

    pub const json_field_names = .{
        .additional_locations = "AdditionalLocations",
        .bucket_columns = "BucketColumns",
        .columns = "Columns",
        .compressed = "Compressed",
        .input_format = "InputFormat",
        .location = "Location",
        .number_of_buckets = "NumberOfBuckets",
        .output_format = "OutputFormat",
        .parameters = "Parameters",
        .schema_reference = "SchemaReference",
        .serde_info = "SerdeInfo",
        .skewed_info = "SkewedInfo",
        .sort_columns = "SortColumns",
        .stored_as_sub_directories = "StoredAsSubDirectories",
    };
};
