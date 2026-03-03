/// Specifies a Delta data store to crawl one or more Delta tables.
pub const DeltaTarget = struct {
    /// The name of the connection to use to connect to the Delta table target.
    connection_name: ?[]const u8 = null,

    /// Specifies whether the crawler will create native tables, to allow
    /// integration with query engines that support querying of the Delta
    /// transaction log directly.
    create_native_delta_table: ?bool = null,

    /// A list of the Amazon S3 paths to the Delta tables.
    delta_tables: ?[]const []const u8 = null,

    /// Specifies whether to write the manifest files to the Delta table path.
    write_manifest: ?bool = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .create_native_delta_table = "CreateNativeDeltaTable",
        .delta_tables = "DeltaTables",
        .write_manifest = "WriteManifest",
    };
};
