/// The configuration that contains the database path of the data that you want
/// to place on each selected volume. Each segment must have a unique database
/// path for each volume. If you do not explicitly specify any database path for
/// a volume, they are accessible from the cluster through the default S3/object
/// store segment.
pub const KxDataviewSegmentConfiguration = struct {
    /// The database path of the data that you want to place on each selected volume
    /// for the segment. Each segment must have a unique database path for each
    /// volume.
    db_paths: []const []const u8,

    /// Enables on-demand caching on the selected database path when a particular
    /// file or a
    /// column of the database is accessed. When on demand caching is **True**,
    /// dataviews perform minimal loading of files on the filesystem as
    /// needed. When it is set to **False**, everything is cached. The
    /// default value is **False**.
    on_demand: bool = false,

    /// The name of the volume where you want to add data.
    volume_name: []const u8,

    pub const json_field_names = .{
        .db_paths = "dbPaths",
        .on_demand = "onDemand",
        .volume_name = "volumeName",
    };
};
