/// Describes a `COPY` command for Amazon Redshift.
pub const CopyCommand = struct {
    /// Optional parameters to use with the Amazon Redshift `COPY` command. For
    /// more information, see the "Optional Parameters" section of [Amazon Redshift
    /// COPY command](https://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html).
    /// Some possible
    /// examples that would apply to Firehose are as follows:
    ///
    /// `delimiter '\t' lzop;` - fields are delimited with "\t" (TAB character) and
    /// compressed using lzop.
    ///
    /// `delimiter '|'` - fields are delimited with "|" (this is the default
    /// delimiter).
    ///
    /// `delimiter '|' escape` - the delimiter should be escaped.
    ///
    /// `fixedwidth 'venueid:3,venuename:25,venuecity:12,venuestate:2,venueseats:6'`
    /// -
    /// fields are fixed width in the source, with each width specified after every
    /// column in the
    /// table.
    ///
    /// `JSON 's3://mybucket/jsonpaths.txt'` - data is in JSON format, and the path
    /// specified is the format of the data.
    ///
    /// For more examples, see [Amazon Redshift COPY command
    /// examples](https://docs.aws.amazon.com/redshift/latest/dg/r_COPY_command_examples.html).
    copy_options: ?[]const u8 = null,

    /// A comma-separated list of column names.
    data_table_columns: ?[]const u8 = null,

    /// The name of the target table. The table must already exist in the database.
    data_table_name: []const u8,

    pub const json_field_names = .{
        .copy_options = "CopyOptions",
        .data_table_columns = "DataTableColumns",
        .data_table_name = "DataTableName",
    };
};
