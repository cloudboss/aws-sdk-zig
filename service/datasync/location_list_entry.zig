/// Represents a single entry in a list of locations. `LocationListEntry`
/// returns an array that contains a list of locations when the
/// [ListLocations](https://docs.aws.amazon.com/datasync/latest/userguide/API_ListLocations.html) operation is
/// called.
pub const LocationListEntry = struct {
    /// The Amazon Resource Name (ARN) of the location. For Network File System
    /// (NFS) or Amazon EFS,
    /// the location is the export path. For Amazon S3, the location is the prefix
    /// path that you
    /// want to mount and use as the root of the location.
    location_arn: ?[]const u8 = null,

    /// Represents a list of URIs of a location. `LocationUri` returns an array that
    /// contains a list of locations when the
    /// [ListLocations](https://docs.aws.amazon.com/datasync/latest/userguide/API_ListLocations.html) operation is
    /// called.
    ///
    /// Format: `TYPE://GLOBAL_ID/SUBDIR`.
    ///
    /// TYPE designates the type of location (for example, `nfs` or
    /// `s3`).
    ///
    /// GLOBAL_ID is the globally unique identifier of the resource that backs the
    /// location. An
    /// example for EFS is `us-east-2.fs-abcd1234`. An example for Amazon S3 is the
    /// bucket
    /// name, such as `myBucket`. An example for NFS is a valid IPv4 or IPv6 address
    /// or a hostname
    /// that is compliant with DNS.
    ///
    /// SUBDIR is a valid file system path, delimited by forward slashes as is the
    /// *nix
    /// convention. For NFS and Amazon EFS, it's the export path to mount the
    /// location. For
    /// Amazon S3, it's the prefix path that you mount to and treat as the root of
    /// the
    /// location.
    location_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
    };
};
